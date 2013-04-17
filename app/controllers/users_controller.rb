class UsersController < ApplicationController
  def new
    session[:return_to] = params[:return_to]
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = :user unless @user.role
    if @user.email
      @user.display_name = @user.full_name unless @user.display_name
    end

    if @user.save
      auto_login(@user)
      send_account_confirmation(@user.email)

      destination = session.delete(:return_to) || root_url
      redirect_to destination, notice: "Hi #{@user.full_name}, your account has been successfully created!"
    else
      render :new
    end
  end

  def show
    @user = current_user
    unless @user
      redirect_to root_path
      flash[:error] = "You are not permitted to view that user."
      return
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_user(params[:role], params[:store_id])
    redirect_to :back
  end

  private

  def send_account_confirmation(email)
    Resque.enqueue(NewUserConfirmation, email)
  end
end
