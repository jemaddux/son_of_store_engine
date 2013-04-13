require 'spec_helper'

describe CategoriesController do

  def valid_session
    {}
  end

  describe "GET index" do

    it "assigns all categories as @categories" do
      category = Category.create(name: "something")
      get :index, {}, valid_session
      assigns(:categories).should eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      store_id = Store.create(name: "some_store", description: "a new store", path: "some_store").name
      category = Category.create(name: "something", store_id: store_id)
      get :show, {:id => category.id, store_id: store_id}, valid_session
      assigns(:category).should eq(category)
    end
  end
end
