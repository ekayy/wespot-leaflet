class Place < ActiveRecord::Base
  attr_accessible :business_name, :street, :city, :zip, :state, :country, :phone

  belongs_to :user
end
