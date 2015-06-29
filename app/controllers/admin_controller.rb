class AdminController < ApplicationController
	layout "user"
	before_filter :authenticate_user!
	before_filter :admin_authorize
	before_filter :set_cache_buster
	def index
		@products = Product.all
	end
end
