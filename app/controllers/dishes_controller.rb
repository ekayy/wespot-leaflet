class DishesController < ApplicationController

  def show
    @dish = Dish.find(params[:id])
    @commentable = @dish
    @comments = @commentable.comments
    @comment = Comment.new
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end

