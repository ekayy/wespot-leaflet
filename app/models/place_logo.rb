class PlaceLogo < ActiveRecord::Base
  belongs_to :logo
  belongs_to :place
end
