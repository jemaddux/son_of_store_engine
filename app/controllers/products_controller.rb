class ProductsController < ApplicationController
  def index

    @dashboard = Dashboard.new
    authorize! :manage, Product

    render :index
  end
end
