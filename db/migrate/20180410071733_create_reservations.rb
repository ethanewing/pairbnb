class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :num_guests
      t.belongs_to :user, index: true
      t.belongs_to :listing, index: true
      t.timestamps
    end
  end
end
