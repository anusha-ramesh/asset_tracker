class Product < ActiveRecord::Base
  belongs_to :product_type
  has_many :inventories
  has_many :users, through: :inventories
  attr_accessible :asset_name, :image, :product_type_id, :inventories_attributes
  validates :asset_name, uniqueness: true
  validates :asset_name, :image, :presence => true
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  accepts_nested_attributes_for :inventories
end
