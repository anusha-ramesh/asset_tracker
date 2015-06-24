class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :inventories, :User_id, :user_id
  	rename_column :inventories, :Product_id, :product_id
  	rename_column :products, :ProductType_id, :product_type_id
  end
end
