class Listing < ApplicationRecord
	validates :address, uniqueness: true
end