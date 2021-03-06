class Event < ApplicationRecord
  belongs_to :group
  has_one_attached :featured_image
  validates :title, presence: true
  validates :description, presence: true
 
  def featured_image_url
    if self.featured_image.attachment
      self.featured_image.attachment.service_url
    end
  end
end
