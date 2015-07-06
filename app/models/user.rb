class User < ActiveRecord::Base
  has_many :inventories
  has_many :products, through: :inventories
  devise :ldap_authenticatable, :rememberable, :trackable
  attr_accessible :email, :password, :remember_me, :user_name
  scope :asset_user, -> { where(arel_table[:user_name].not_eq("admin")) }
  scope :asset_admin, -> { where(user_name: "admin")}

  def ldap_before_save
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.user_name, "cn").first
    if(self.user_name != "admin") 
      self.email = Devise::LDAP::Adapter.get_ldap_param(self.user_name,"mail").first
    end
  end
end
