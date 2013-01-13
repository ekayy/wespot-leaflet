class Admin::PlacesController < ApplicationController
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    if params[:search].present?
    @places = Place.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(30)
    else
      @places = Place.order(sort_column + ' ' + sort_direction).page(params[:page]).per(30)
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        format.html { redirect_to admin_places_url, notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: [:admin,@place] }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @place = Place.find(params[:id])
    @dishes = @place.dishes
    @articles = @place.articles
  end

  def update
    respond_to do |format|
    @place = Place.find(params[:id])
      if @place.update_attributes(params[:place])
        format.html { redirect_to edit_admin_place_path, notice: 'Place was successfully updated.' }
        format.json { render json: @place,  location: [:admin,@place] }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Place.find(params[:id]).destroy
    flash[:success] = "Place destroyed."
    redirect_to users_url
  end

  private
  def sort_column
    Place.column_names.include?(params[:sort]) ? params[:sort] : "business_name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end

