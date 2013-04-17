class Admin::AdminController < ActionController::Base

  layout "application"

  before_filter :require_admin_login

  def remove
    @user = User.find(params[:id])
    @user.update_user_role(params[:role], @user.store_id)
    notice = "Store must have at least one Admin"
    if (@user.role == "user")
      (notice = "Admin removed")
    end
    redirect_to :back, notice: notice
  end

  def administer
    current_user.store_id = params[:store_id]
    user = User.find(current_user.id)
    user.store_id = params[:store_id]
    user.save!
    redirect_to store_index_path(params[:path])
  end

  def new_admin
    user = User.find_by_email(params[:email])
    if params["commit"] == "Create New Admin"
      role = "admin"
    else
      role = "stocker"
    end
    if user.nil?
      temp_password = create_random_password(10)
      User.create(full_name: "Pending", store_id: params[:store_id],
                  email: params[:email], role: "pending_#{role}",
                  password: temp_password)
      store_name = Store.find(params[:store_id]).name
      Resque.enqueue(SendNewAdminEmail, params[:email],
                      store_name, temp_password)
    else
      user.role = role
      puts "hello"
      user.store_id = params[:store_id]
      user.save
      store_name = Store.find(params[:store_id]).name
      Resque.enqueue(MakeUserNewAdmin, params[:email], store_name)
    end
    redirect_to :back
  end

  def create_admin
    admin = User.find_by_email(current_user.email)
    if admin.role == "pending_admin"
      admin.role = "admin"
    else
      admin.role = "stocker"
    end
    admin.full_name = params[:full_name]
    admin.password = params[:password]
    admin.save
    redirect_to "/"
  end

  def signup_admin
    @user = User.new
    render :signup_admin
  end

  private

  def create_random_password(length)
    x ||= [('a'..'z'),('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten
    (0..(length-1)).map{ x[rand(x.length)] }.join
  end

  def require_admin_login
    if !current_user || !current_user.role == "admin"
      redirect_to login_path
    end
  end
end
