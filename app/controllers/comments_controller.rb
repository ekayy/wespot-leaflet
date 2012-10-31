class CommentsController < ApplicationController

  def index
  	@commentable = Place.find(params[:place_id])
  	@place = @commentable
  	@comments = @commentable.comments
  	@comment = Comment.new
  end

  def new
  	@commentable = Place.find(params[:place_id])
  	@comment = @commentable.comments.new(params[:comment])
  end

  def create
  	@commentable = Place.find(params[:place_id])
	  @comment = @commentable.comments.new(params[:comment])
	  if @comment.save
	    redirect_to @commentable, notice: "Comment created."
	  else
	    render :new
	  end
	end
end
