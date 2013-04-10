class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    authorize! :manage, @category

    render :index
  end

  def show
    @category = Category.find(params[:id])
    @categories = Category.all.sort

    render :show
  end
end
