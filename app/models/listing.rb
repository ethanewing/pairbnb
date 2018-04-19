class Listing < ApplicationRecord
	validates :address, uniqueness: true, presence: true
	validates :max_guests, :bedrooms, :baths, :amenities, :rate_in_usd, presence: true
	scope :location_tag, -> (location_tag) { where("address ILIKE ? OR ? ILIKE ANY(tags)", "%#{location_tag}%", "#{location_tag}") }
	scope :baths, -> (num) { where(baths: num) }
	scope :bedrooms, -> (num) { where(bedrooms: num) }
	scope :max_price, -> (max) { where("rate_in_usd <= ?", max) }

	# def self.location_tag(location_tag)
	# 	where("address ILIKE ? OR ? ILIKE ANY(tags)", "%#{location_tag}%", "#{location_tag}")
	# end
	#
	# def self.baths(num)
	# 	where(baths: num)
	# end
	#
	# def self.bedrooms
end
