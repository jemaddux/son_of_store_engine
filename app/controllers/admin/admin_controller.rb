class Admin::AdminController < ActionController::Base

  #layout "application"

  before_filter :require_admin_login

  private
  def require_admin_login
    if !current_user || !current_user.admin
      redirect_to login_path
    end
  end
end
