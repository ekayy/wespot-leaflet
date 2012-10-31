class Place < ActiveRecord::Base
  attr_accessible :business_name, :street, :city, :zip, :state, :country, :phone, :tag_list

  belongs_to :user
  has_many :comments, as: :commentable

  acts_as_taggable
end
