class Admin::UsersController < ApplicationController
	before_filter :authenticate_user!

  def index
  	@users = User.all
  end

  def new
  	@user = User.new
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
end

