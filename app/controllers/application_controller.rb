class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
    if(current_user.user_name == "admin")
      admin_index_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def admin_authorize
    redirect_to new_user_session_path unless current_user.user_name == "admin"
  end

end
