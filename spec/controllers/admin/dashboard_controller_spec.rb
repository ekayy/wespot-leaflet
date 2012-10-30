require 'spec_helper'

describe Admin::DashboardController do

  describe 'user access' do

  	describe "GET 'index" do

      before (:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

  		it "returns http success" do

  			get 'index'
  			response.should be_success
  		end
  	end
  end

  describe 'non-user access' do
  	describe "GET 'index'" do
  		it "redirects to the login form" do
  			get 'index'
  			response.should redirect_to new_user_session_path
  		end
  	end
  end
end
