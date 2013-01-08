class Logo < ActiveRecord::Base
  attr_accessible :name, :url

  has_many :places, through: :place_logos
  has_many :place_logos
end
