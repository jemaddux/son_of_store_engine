class UsersController < ApplicationController
  def new
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
      flash[:green] = "Your account has been successfully created!"
      send_account_confirmation(@user.email)
      redirect_to root_url
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

  private

  def send_account_confirmation(email)
    UserMailer.account_confirmation(email).deliver
  end
end
