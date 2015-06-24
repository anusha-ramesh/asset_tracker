class Inventory < ActiveRecord::Base
  belongs_to :User
  belongs_to :Product
  attr_accessible :asset_code, :product_id
end
