# Read about factories at https://github.com/thoughtbot/factory_girl

	FactoryGirl.define do
	  factory :user do
	    sequence(:name)  { |n| "Person #{n}" }
 			sequence(:email) { |n| "person_#{n}@example.com"}
 			password "foobar"
   	  password_confirmation "foobar"
	    # required if the Devise Confirmable module is used
	    # confirmed_at Time.now
		  factory :admin do
	      after(:create) {|user| user.add_role(:admin)}
	    end
	  end

	  factory :place do
	  	business_name "Izakaya"
	  	street "1470 38th Ave"
	  	city "San Francisco"
	  	state "California"
	  	zip "94122"
	  end
	end
