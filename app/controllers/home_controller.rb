class HomeController < ApplicationController
	layout "user"
	before_filter :authenticate_user!
	before_filter :set_cache_buster
	def index
      @user = User.find(current_user)
      @products = @user.products.page params[:page]
	end
end
