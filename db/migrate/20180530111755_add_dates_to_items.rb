class AddDatesToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :start_date, :date
    add_column :items, :end_date, :date
  end
end
