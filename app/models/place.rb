class Place < ActiveRecord::Base
  attr_accessible :business_name, :street, :city, :zip, :state, :country, :phone, :latitude, :longitude, :tag_list, :coverphoto, :comment_attributes

  belongs_to :user
  has_many :comments, as: :commentable

  validates_presence_of :business_name
  acts_as_taggable
  acts_as_gmappable
  mount_uploader :coverphoto, CoverphotoUploader

 
  # def self.text_search(query)
  #   if query.present?
  #     where("business_name @@ :q", q: query) | tagged_with(query)
  #   else
  #     scoped
  #   end
  # end

  def self.text_search(query)
    if query.present?
      where("business_name @@ :q", q: query) | tagged_with(query)
    else
      scoped
    end
  end

  def gmaps4rails_address
    "#{self.street}, #{self.city}, #{self.state}, #{self.zip}"
  end

  # private
  # def reprocess_image
  #   Place.all.each do |place|
  #     place.coverphoto.recreate_versions!
  #   end
  # end
end


