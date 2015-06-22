class Assets < ActiveRecord::Base
  belongs_to :users
  attr_accessible :asset_name, :asset_type
end
