class PlacesController < ApplicationController

  def index
    if params[:query]
      @places = Place.where("business_name @@ :q", q: params[:query]) | Place.tagged_with(params[:query])
    	@places = Kaminari.paginate_array(@places).page(params[:page]).per(40)
    else
      @places = Place.order("created_at ASC").page(params[:page]).per(40)
    end

    # if params[:query_location].present?
    #   @places = Place.near(params[:query_location], 15, :order => :distance).text_search(params[:query])
    # else
    #   @places = Place.text_search(params[:query])
    # end

    @json = Place.all.to_gmaps4rails
  end

  def show
  	@place = Place.find(params[:id])
  	@commentable = @place
  	@comments = @commentable.comments
  	@comment = Comment.new
    @twitter = Twitter.user_timeline(@place.business_name, :count => 2)
    if @place.latitude.nil?
      @instagram  = Instagram.media_search(20, 32)
    else
      @instagram = Instagram.media_search(@place.latitude, @place.longitude, { :distance => 10 })
    end
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @place = Place.find(params[:id])
    @place.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting!"
  end

  def feed
  end
end
