class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :inventories
  has_many :products, through: :inventories
  devise :ldap_authenticatable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :user_name
  scope :asset_user, -> { where(arel_table[:user_name].not_eq("admin")) }
  # attr_accessible :title, :body
  #before_save :get_ldap_email
  #def get_ldap_email
     # Rails::logger.info("### Getting the users email address")
     # tempmail = Devise::LdapAdapter.get_ldap_param(self.username,"mail")
      #self.email = tempmail
  #end

  def ldap_before_save
    self.email = Devise::LDAP::Adapter.get_ldap_param(self.user_name, "cn").first
    if(self.user_name != "admin") 
      self.email = Devise::LDAP::Adapter.get_ldap_param(self.user_name,"mail").first
    end
  end
end
