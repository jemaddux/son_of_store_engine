class Admin::AdminController < ActionController::Base

  layout "application"

  before_filter :require_admin_login

  def new_admin
    user = User.find_by_email(params[:email])
    if user.nil?
      temp_password = create_random_password(10)
      User.create(full_name: "Pending Admin", store_id: params[:store_id], email: params[:email], role: "pending_admin", password: temp_password)
      store_name = Store.find(params[:store_id]).name
      UserMailer.new_admin(params[:email], store_name, temp_password).deliver
    else
      user.role = "admin"
      user.store_id = params[:store_id] #something
      user.save
      store_name = Store.find(params[:store_id]).name
      UserMailer.add_admin(params[:email], store_name).deliver
    end
    redirect_to :back
  end

  def create_admin
    admin = User.find_by_email(current_user.email)
    admin.role = "admin"
    admin.full_name = params[:full_name]
    admin.password = params[:password]
    admin.save
    redirect_to "/", :notice => params.inspect
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
