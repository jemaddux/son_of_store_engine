class HomeController < ApplicationController
  caches_page :show

  def show

    @user ||= current_user

    render layout: "home"
  end

  def profile

    @user ||= current_user
    
    render layout: "profile"
  end
end
