class User < ApplicationRecord
  include Clearance::User
  mount_uploader :avatar, AvatarUploader
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :role, presence: true
  has_many :authentications, dependent: :destroy
  has_many :reservations
  has_many :listings
  before_validation :default_role_and_username, except: [:update]

  def self.create_wtih_auth_and_hash(authentication, auth_hash)
  	user = self.create!(
  		username: auth_hash["name"],
  		email: auth_hash["extra"]["raw_info"]["email"]
  	)
  	user.authentications << authentication
  	return user
  end

  # grab fb_token to access Facebook for user data
  def fb_token
  	x = self.authentications.find_by(provider: 'facebook')
  	return x.token unless x.nil?
  end

  def default_role_and_username
    if self.role.nil?
      self.role = "customer"
    end
    if self.username.nil?
      self.username = "#{Faker::ElderScrolls.first_name}#{Faker::ElderScrolls.first_name}"
    end
  end
end
