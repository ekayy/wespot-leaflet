class Dish < ActiveRecord::Base
  attr_accessible :name, :image, :description, :remote_image_url
  belongs_to :place
  mount_uploader :image, ImageUploader
  has_many :comments, as: :commentable
  has_reputation :votes, source: :user, aggregated_by: :sum
end
