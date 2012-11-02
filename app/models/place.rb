class Place < ActiveRecord::Base
  attr_accessible :business_name, :street, :city, :zip, :state, :country, :phone, :tag_list, :coverphoto, :comment_attributes

  belongs_to :user
  has_many :comments, as: :commentable


  acts_as_taggable

  mount_uploader :coverphoto, CoverphotoUploader

  def self.text_search(query)
    if query.present?
      where("business_name @@ :q", q: query) | tagged_with(query) 
    else
      scoped
    end
  end


  # private
  # def reprocess_image
  #   Place.all.each do |place|
  #     place.coverphoto.recreate_versions!
  #   end
  # end
end


