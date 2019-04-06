class Event < ApplicationRecord
  belongs_to :group
  has_one_attached :featured_image

  def featured_image_url
    if self.featured_image.attachment
      self.featured_image.attachment.service_url
    end
  end
end
