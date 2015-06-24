class InventoriesController < ApplicationController
	respond_to :js, :html
	#def create
		#@inventories = Inventory.new(inventory_params)
	  #if @inventories.save
			#respond_to do |format|
        #format.html { redirect_to new_product_path}
        #format.json { head :no_content }
        #format.js   { render :layout => false }
      #end
		#else
			#redirect_to  new_inventory_path
		#end
	#end

	def new
  end

 # private

  #def inventory_params
  	#params.permit(:asset_code, :Product_id)
  #end
end
