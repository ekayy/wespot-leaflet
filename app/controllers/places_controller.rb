class PlacesController < ApplicationController

  def index
    if params[:query]
      @places = Place.where("business_name @@ :q", q: params[:query]) | Place.tagged_with(params[:query])
    	@places = Kaminari.paginate_array(@places).page(params[:page]).per(10)
    else
      @places = Place.order("created_at ASC").page(params[:page]).per(10)
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
  end
end
