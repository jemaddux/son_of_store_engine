class HomeController < ApplicationController
  def show
    render layout: "home"
  end

  def profile
    render layout: "profile"
  end
end
