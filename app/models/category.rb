class Category < ActiveRecord::Base
  has_and_belongs_to_many :places

  attr_accessible :display_name, :key

  validates(:display_name, :presence => true)
  validates(:key, :presence => true, :uniqueness => true)
end