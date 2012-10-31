class PlacesController < ApplicationController
  def index
  end

  def show
  	@place = Place.find(params[:id])
  	@commentable = @place
  	@comments = @commentable.comments
  	@comment = Comment.new
  end
end
