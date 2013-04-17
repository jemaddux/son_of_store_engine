class ProductsController < ApplicationController
  caches_page :show

  def show
    @product = Product.find_by_id(params[:id])
  end
end
