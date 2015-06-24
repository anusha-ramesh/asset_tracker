class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :asset_name
      t.references :ProductType

      t.timestamps
    end
    add_index :products, :ProductType_id
  end
end
