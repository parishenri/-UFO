class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :rental_price
      t.integer :buying_price
      t.string :size
      t.boolean :availability
      t.boolean :rental_only
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
