class User < ApplicationRecord
    # Include default devise modules.
  has_many :groups, dependent: :destroy
  devise :database_authenticatable, :registerable,
                    :recoverable, :rememberable, :trackable, :validatable,
                    :omniauthable
  include DeviseTokenAuth::Concerns::User

  def tokens_has_json_column_type?
    false
  end
end
