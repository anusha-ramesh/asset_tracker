class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :asset_code
      t.references :User
      t.references :Product

      t.timestamps
    end
    add_index :inventories, :User_id
    add_index :inventories, :Product_id
  end
end
