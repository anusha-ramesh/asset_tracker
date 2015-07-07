class UserMailer < ActionMailer::Base
  default from: "assettrackerqb@gmail.com"
  def asset_release(user,current_user,inventory)
  	@user = user
  	@inventory = inventory
  	@current_user = current_user
    mail(to: @user.email, subject: 'QuickAsset - Request Release')
  end
  
  def asset_request(user,current_user,inventory)
  	@user = user
  	@current_user = current_user
  	@inventory = inventory
    mail(to: User.asset_admin.map(&:email) , subject: 'QuickAsset - Request For Asset')
  end

  def back_to_shelf(current_user,inventory)
  	@current_user = current_user
  	@inventory = inventory
  	mail(to: User.asset_admin.map(&:email) , subject: 'QuickAsset - Asset Back to Shelf')
  end
end
