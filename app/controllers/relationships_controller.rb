class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @place = Place.find(params[:relationship][:followed_id])
    current_user.follow!(@place)
    redirect_to @place
  end

  def destroy
    @place = Relationship.find(params[:id]).followed
    current_user.unfollow!(@place)
    redirect_to @place
  end
end