class PlacesController < ApplicationController

  def index
    if params[:query].present?
      @places = Place.near(params[:query_location], 5, :order => :distance).where("business_name @@ :q", q: params[:query]) | Place.tagged_with(params[:query])
    	@places = Kaminari.paginate_array(@places).page(params[:page]).per(15)
    elsif params[:query_location].present?
      @places = Place.near(params[:query_location], 5, :order => :distance).page(params[:page]).per(15)
    else
      @places = Place.near([37.7750, -122.4183]).page(params[:page]).per(15)
      # @places = Place.order("created_at ASC").page(params[:page]).per(15)
    end

    # if params[:query_location].present?
    #   @places = Place.near(params[:query_location], 15, :order => :distance).text_search(params[:query])
    # else
    #   @places = Place.text_search(params[:query])
    # end

    @json = @places.to_gmaps4rails do |place, marker|
      marker.infowindow render_to_string(:partial => "/places/infowindow", :locals => { :object => place})
      marker.title   "i'm the title"
    end
  end

  def show
  	@place = Place.find(params[:id])
  	@commentable = @place
  	@comments = @commentable.comments
  	@comment = Comment.new
    @twitter = Twitter.user_timeline(@place.twitterid, :count => 2)
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
    # @recentcomments = Comment.order('created_at DESC').limit(10)
    # @recentcomments = Comment.all(:order => 'created_at DESC', :limit => 10)
    @instagram = Instagram.tag_recent_media('wespot')
    # @feed = [ Comment ].inject([ ]) do |a, with_class|
    #    a + with_class.find(:all, :limit => 10, :order => 'created_at DESC')end.sort_by(&:created_at).reverse[0, 10]
    @comments = Comment.all(:order => 'created_at DESC', :limit => 10)
    @activities = (@comments).sort_by {|a| a.created_at}.reverse
  end
end
