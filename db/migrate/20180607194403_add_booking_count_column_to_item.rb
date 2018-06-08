class AddBookingCountColumnToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :bookingcnt, :integer, default: 0
  end
end
