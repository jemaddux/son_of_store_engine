require 'spec_helper'

describe CategoriesController do

  before (:each) do
    @ability = Object.new
    @first_store = Store.create(name: "some_store", description: "a new store", path: "some_store")
    @ability.extend(CanCan::Ability)
    @controller.stub(:current_ability).and_return(@ability)
  end

  def valid_attributes
    { "name" => "MyString", store_id: @first_store.id }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      category = Category.create! valid_attributes
      get :index, {}, valid_session
      assigns(:categories).should eq([category])
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      category_id = Category.create!(valid_attributes).id
      get :show, {:id => category_id}, valid_session
      assigns(:category).should eq(category)
    end
  end
end
