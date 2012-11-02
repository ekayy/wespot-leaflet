class PlacesController < ApplicationController

  def index
  	@places = Place.text_search(params[:query])
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
