class Inventory < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  attr_accessible :asset_code, :product_id
end
