class User < ApplicationRecord
  include Clearance::User
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :encrypted_password, uniqueness: true
  has_many :authentications, dependent: :destroy

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
end
