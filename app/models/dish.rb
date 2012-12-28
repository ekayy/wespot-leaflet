class Dish < ActiveRecord::Base
  attr_accessible :name
  belongs_to :place
end
