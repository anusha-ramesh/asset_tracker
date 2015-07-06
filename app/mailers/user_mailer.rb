class UserMailer < ActionMailer::Base
  default from: "studenttestmail1@gmail.com"
  def asset_release(user)
  	@user = user
    mail(to: @user.email, subject: 'QuickAsset - Request Release')
  end
  
  # def asset_request(user)
  # 	@user = user

  # 	mail(to:  , subject: 'QuickAsset - Request For Asset')
  # end
end
