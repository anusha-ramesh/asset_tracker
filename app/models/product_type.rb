class ProductType < ActiveRecord::Base
  has_many :products
  attr_accessible :asset_type
  validates :asset_type, uniqueness: true, presence: true
end
