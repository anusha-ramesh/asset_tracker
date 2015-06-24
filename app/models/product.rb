class Product < ActiveRecord::Base
  belongs_to :ProductType
  has_many :inventories
  has_many :users, through: :inventories
  attr_accessible :asset_name, :image, :product_type_id, :inventories_attributes
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  accepts_nested_attributes_for :inventories
end
