require 'spec_helper'

describe Admin::UsersController do
	describe 'user access' do

		before :each do
			user = User.create(
				email: 'admin@example.com',
				password: 'secret',
        password_confirmation: 'secret'
      )
      sign_in user
    end

	  describe "GET :index" do
	    it "returns http success" do
	      get 'index'
	      response.should be_success
	    end
	  end

	  describe "GET :new" do
	  	it "returns http success" do
	  		get :new
	  		response.should be_success
	  	end
	  end
	end

	describe 'non-user access' do
    describe "GET :index" do
      it "redirects to the login form" do
        get :index
        response.should redirect_to new_user_session_path
      end
    end

    describe "GET :new" do
      it "redirects to the login form" do        
        get :new
        response.should redirect_to new_user_session_path
      end
    end
  end
end