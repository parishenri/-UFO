class AddPhotosToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :photo, :string
  end
end
