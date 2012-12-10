class Place < ActiveRecord::Base
  attr_accessible :business_name, :street, :city, :zip, :state, :country, :phone, :latitude, :longitude, :tag_list, :coverphoto, :comment_attributes, :promo, :twitterid

  belongs_to :user
  has_many :comments, as: :commentable

  has_reputation :votes, source: :user, aggregated_by: :sum

  validates_presence_of :business_name
  acts_as_taggable
  acts_as_gmappable
  mount_uploader :coverphoto, CoverphotoUploader


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

  # FriendlyID
  extend FriendlyId
  friendly_id :business_name, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end

  # private
  # def reprocess_image
  #   Place.all.each do |place|
  #     place.coverphoto.recreate_versions!
  #   end
  # end
end


