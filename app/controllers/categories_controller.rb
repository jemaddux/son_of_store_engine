class CategoriesController < ApplicationController  
  def index
    @categories = Category.all
    authorize! :manage, @category

    render :index
  end

  def show
    @store = Store.includes(:categories).find_by_path(params[:store_id])
    @category = Category.find(params[:id])
    @categories = @store.categories.sort

    # render :show
  end
end
