class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
    	t.belongs_to :user, index: true
    	t.text :amenities
    	t.string :address
    	t.integer :max_guests
    	t.integer :bedrooms
  		t.integer :baths
  		t.text :house_rules
  		t.text :cancellations
  		t.text :sleeping_arrangements
  		t.decimal :rate_in_usd, precision: 6, scale: 2
  		t.string :tags, array: true
    end
  end
end
