class Category < ApplicationRecord
	belongs_to :group, dependent: :destroy
end
