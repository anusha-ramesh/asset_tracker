class ProductsTypesController < ApplicationController
	layout "user"
	before_filter :authenticate_user!
	before_filter :admin_authorize
	before_filter :set_cache_buster
	def new
		@product_type = ProductType.new
	end

	def create
		@product_type = ProductType.new(params[:product_type])
		if @product_type.save
			flash[:notice] = "Added to list"
			redirect_to new_products_type_path
		else
			flash[:alert] = "Not saved or Alredy added"
			redirect_to new_products_type_path
		end
	end

end
