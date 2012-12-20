class Place < ActiveRecord::Base
  attr_accessible :business_name, :street, :city, :zip, :state, :country, :phone, :latitude, :longitude, :tag_list, :coverphoto, :comment_attributes, :promo, :twitterid

  belongs_to :user
  has_many :comments, as: :commentable

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

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

  geocoded_by :gmaps4rails_address
  def gmaps4rails_address
    "#{self.street}, #{self.city}, #{self.state}, #{self.zip}"
  end

  scope :followers, -> { where("follower = ?")}

  # FriendlyID
  extend FriendlyId
  friendly_id :business_name, use: :slugged

  def should_generate_new_friendly_id?
    new_record?
  end

  # def gmaps4rails_marker_picture
  #     {
  #     "picture" => self.coverphoto_url(:mini).to_s, # image_path column has to contain something like '/assets/my_pic.jpg'.
  #     "width" => 75, #beware to resize your pictures properly
  #     "height" => 50 #beware to resize your pictures properly
  #     }
  # end

  # private just uncomment
  #reprocess_image:
    # Place.all.each do |place|
    #   place.coverphoto.recreate_versions!
    # end
  #
end


