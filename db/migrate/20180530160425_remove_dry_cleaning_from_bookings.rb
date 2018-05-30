class RemoveDryCleaningFromBookings < ActiveRecord::Migration[5.2]
  def change
    remove_column :bookings, :dry_cleaning, :string
  end
end
