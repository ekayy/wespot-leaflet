class Article < ActiveRecord::Base
  attr_accessible :image, :snippet, :title, :url, :remote_image_url
  belongs_to :place
  mount_uploader :image, ArticleimageUploader

  validates_presence_of :title
  # validates_length_of :snippet, :maximum => 200
end
