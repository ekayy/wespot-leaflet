require 'spec_helper'

describe Admin::DashboardController do

  describe 'user access' do

  	describe "GET 'index" do
  		it "returns http success" do
  			user = User.create(
  				email: 'admin@example.com',
  				password: 'secret',
  				password_confirmation: 'secret'
  			)
  			visit root_path
		    click_link 'Login'
		    fill_in 'Email', with: 'admin@example.com'
		    fill_in 'Password', with: 'secret'
		    click_button 'Sign in'

  			get 'index'
  			response.should == 1
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
