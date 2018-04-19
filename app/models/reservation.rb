class Reservation < ApplicationRecord
  validates :user_id, presence: true
  validates :listing_id, presence: true
end
