# Read about factories at https://github.com/thoughtbot/factory_girl

	FactoryGirl.define do
	  factory :user do
	    name 'Test User'
	    email 'usertest@example.com'
	    password 'secret'
	    password_confirmation 'secret'
	    # required if the Devise Confirmable module is used
	    # confirmed_at Time.now
		 # factory :admin do
	   #      after(:create) {|user| user.add_role(:admin)}
	    end
	  end
	end
