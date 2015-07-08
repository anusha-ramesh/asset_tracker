class Inventory < ActiveRecord::Base
  has_paper_trail
  belongs_to :user
  belongs_to :product
  attr_accessible :asset_code, :product_id, :user_id
  validates :asset_code, :presence => true
  # scope :asset_state, -> { where(created_at: Date.today)}
end
