class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.integer :number_of_users
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
