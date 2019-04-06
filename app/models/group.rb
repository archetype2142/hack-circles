class Group < ApplicationRecord
  belongs_to :user
  has_many :events
  has_one_attached :featured_image
  validates :name, presence: true
  validates :description, presence: true
  
  def featured_image_url
    if self.featured_image.attachment
      self.featured_image.attachment.service_url
    end
  end
end
