class HomeController < ApplicationController
  def show
    @categories = Category.all.sort
    @products = Category.find_by_name("Essentials").products.shuffle[0..2]
    render layout: "home"
  end

  def profile
    render layout: "profile"
  end
end
