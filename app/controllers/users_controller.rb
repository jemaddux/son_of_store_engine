class UsersController < ApplicationController
  caches_page :show
  
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
      redirect_to destination, notice: %Q[Hi #{@user.full_name}, your account has been successfully created! You can update your account <a href="/users/#{@user.id}/edit?redirect=/">here</a>]
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
    @user.update_user(params[:user])
    @user.save
    destination = session.delete(:return_to) || :back
    redirect_to destination, notice: "Your account has been updated! Name: #{@user.full_name}, Email: #{@user.email}, Display name: #{@user.display_name}."
  end

  def edit
    session[:return_to] = params[:redirect]
    @user = current_user
  end

  private

  def send_account_confirmation(email)
    Resque.enqueue(NewUserConfirmation, email)
  end

end
