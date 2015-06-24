class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :asset_type

      t.timestamps
    end
  end
end
