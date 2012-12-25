class CommentsController < ApplicationController

  def index
  	@commentable = Place.find(params[:place_id])
  	@place = @commentable
  	@comments = @commentable.comments
  	@comment = Comment.new
  end

  def new
  	@commentable = Place.find(params[:place_id])
  	@comment = @commentable.comments.new
  end

  def create
  	@commentable = Place.find(params[:place_id])
	  @comment = @commentable.comments.new(params[:comment])
    @comment.user_id = current_user.id
	  if @comment.save
	    respond_to do |format|
        format.html { redirect_to place_comments_url }
      end
	  else
	    render :new
	  end
	end

  def destroy
    @commentable = Place.find(params[:place_id])
    @comment = @commentable.comments.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to place_comments_url }
      end
    end
  end
end

