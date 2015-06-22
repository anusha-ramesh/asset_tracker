class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :asset_name
      t.string :asset_type
      t.references :users

      t.timestamps
    end
    add_index :assets, :users_id
  end
end
