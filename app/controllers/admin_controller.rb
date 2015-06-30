class AdminController < ApplicationController
	layout "user"
	before_filter :authenticate_user!
	before_filter :admin_authorize
	before_filter :set_cache_buster
	autocomplete :product, :asset_name, :full => true
	helper_method :sort_column, :sort_direction
	def index
	  if params[:search]
        @products = Product.where('asset_name LIKE ?', "%#{params[:search]}%").order(sort_column + " " + sort_direction).page params[:page]
      else
        @products = Product.order(sort_column + " " + sort_direction).page params[:page]
      end
    end

    private

    def sort_column
      Product.column_names.include?(params[:sort]) ? params[:sort] : "asset_name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
