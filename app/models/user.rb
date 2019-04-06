class User < ApplicationRecord
    # Include default devise modules.
  devise :database_authenticatable, :registerable,
                    :recoverable, :rememberable, :trackable, :validatable,
                    :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :groups

    def tokens_has_json_column_type?
      false
    end
end
