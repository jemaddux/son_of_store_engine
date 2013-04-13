class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    authorize! :manage, @category

    render :index
  end

  def show
    @store = Store.find_by_path(params[:store_id])
    @category = Category.find(params[:id])
    @categories = Category.where(store_id: @store.id).sort

    # render :show
  end
end
