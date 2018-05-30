class AddDatesToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :available_start_date, :date
    add_column :items, :available_end_date, :date
  end
end
