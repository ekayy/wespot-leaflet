class Place < ActiveRecord::Base
  attr_accessible :business_name, :street, :city, :zip, :state, :country, :phone, :latitude, :longitude, :tag_list, :coverphoto, :comment_attributes, :promo, :twitterid, :instagramid, :cost_scale, :website, :hours_attributes, :dishes_attributes

  belongs_to :user
  has_many :comments, as: :commentable
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_reputation :votes, source: :user, aggregated_by: :sum
  validates_presence_of :business_name
  has_many :hours, dependent: :destroy
  accepts_nested_attributes_for :hours, allow_destroy: true
  has_many :dishes, dependent: :destroy
  accepts_nested_attributes_for :dishes, allow_destroy: true

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

  def self.filter(option)
    case option.to_sym
    when :cost1
      where(:cost_scale => '$')
    when :cost2
      where(:cost_scale => '$$')
    when :cost3
      where(:cost_scale => '$$$')
    when :followers
      joins(:followers).order("followers_count DESC")
    else
      scope
    end
  end

  scope :popular, all.sort { |a, b| a.followers.count <=> b.followers.count }

  geocoded_by :gmaps4rails_address
  def gmaps4rails_address
    "#{self.street}, #{self.city}, #{self.state}, #{self.zip}"
  end

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

 #  def gmaps4rails_sidebar

 # end

  # private just uncomment
  #reprocess_image:
    # Place.all.each do |place|
    #   place.coverphoto.recreate_versions!
    # end
end


