class ProductsController < ApplicationController
  def index

    @dashboard = Dashboard.new(current_user.store_id)
    #authorize! :manage, All
    render :index
  end
end
