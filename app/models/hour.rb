class Hour < ActiveRecord::Base
  attr_accessible :day, :open_time, :close_time
  belongs_to :place

end