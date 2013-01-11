class Place < ActiveRecord::Base
  attr_accessible :business_name, :street, :city, :zip, :state, :country, :phone, :latitude, :longitude, :tag_list, :coverphoto, :comment_attributes, :promo, :twitterid, :instagramid, :cost_scale, :website, :hours_attributes, :dishes_attributes, :articles_attributes, :logos_attributes, :logo_ids

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
  has_many :articles, dependent: :destroy
  accepts_nested_attributes_for :articles, allow_destroy: true

  has_many :place_logos
  has_many :logos, through: :place_logos
  accepts_nested_attributes_for :logos

  acts_as_taggable
  mount_uploader :coverphoto, CoverphotoUploader

  def self.text_search(query)
    if query.present?
      where("business_name @@ :q", q: query) | tagged_with(query)
    else
      scoped
    end
  end

  def self.filter(option)
    begin
      case option.to_sym
      when :price1
        where(:cost_scale => '$')
      when :price2
        where(:cost_scale => '$$')
      when :price3
        where(:cost_scale => '$$$')
      when :followers
        joins(:followers).order("followers_count DESC")
      when :recent
        joins(:comments).order("created_at DESC")
      when :relevant
      else
        scope
      end
    rescue
      return all
    end
  end



  # def self.within_bounds(bounds)

  #   where(:location.within => {"$box" => bounds })

  # end

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

def gmaps4rails_sidebar
  "<span>test</span>" #put whatever you want here
end

  # private just uncomment
  #reprocess_image:
    # Place.all.each do |place|
    #   place.coverphoto.recreate_versions!
    # end
end


