class DishesController < ApplicationController

  def show
    @dish = Dish.find(params[:id])
    @commentable = @dish
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def destroy
    Dish.find(params[:id]).destroy
    flash[:success] = "Dish destroyed."
    redirect_to(:back)
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end

