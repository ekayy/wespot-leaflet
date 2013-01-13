class Admin::LogosController < ApplicationController
  before_filter :authenticate_user!

  def index
    @logos = Logo.all
  end

  def new
    @logo = Logo.new
  end

  def create
    @logo = Logo.new(params[:logo])
    if @logo.save
      flash[:notice] = "Successfully created logo."
      redirect_to admin_logos_path
    else
      render :action => 'new'
    end
  end

  def destroy
    @logo = Logo.find(params[:id]).destroy
    flash[:success] = "Logo destroyed."
    redirect_to(:back)
  end
end

