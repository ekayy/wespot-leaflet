class Admin::UsersController < ApplicationController
	before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    if params[:search].present?
  	@users = User.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(30)
    else
      @users = User.order(sort_column + ' ' + sort_direction).page(params[:page]).per(30)
    end
  end

  def new
  	@user = User.new
    @place = @user.build_place
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: [:admin,@user] }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  	@user = User.find(params[:id])
  	@place = @user.place
    @dishes = @user.place.dishes
    @articles = @user.place.articles
  end

  def update
  	respond_to do |format|
  	@user = User.find(params[:id])
			if @user.update_without_password(params[:user])
	      format.html { redirect_to edit_admin_user_path, notice: 'User was successfully updated.' }
	      format.json { render json: @user,  location: [:admin,@user] }
	    else
	      format.html { render action: "edit" }
	      format.json { render json: @user.errors, status: :unprocessable_entity }
   		end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end

