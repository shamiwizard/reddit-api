class User < ApplicationRecord
  acts_as_token_authenticatable
  mount_base64_uploader :photo, UserPhotoUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: -> { password.present? }
end
