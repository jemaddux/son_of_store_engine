require 'spec_helper'

describe Admin::ProductsController do

  let(:store){ FactoryGirl.create(:store) }
  let(:product1) { FactoryGirl.create(:product) }
  let(:admin){ FactoryGirl.create(:admin) }

  def valid_attributes
    {name: "Rations", price: 24,
  description: "Good for one 'splorer."}
  end

  def valid_session
    {}
  end

  before (:each) do
    login_user(admin)
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :show, {:id => product.id}, valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "GET new" do
    it "assigns a new product as @product" do
      get :new, {}, valid_session
      assigns(:product).should be_a_new(Product)
    end
  end

  describe "GET edit" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :edit, {:id => product.to_param}, valid_session
      assigns(:product).should eq(product)
    end
  end

  describe "POST create" do
    describe "with valid params and admin access" do
      before (:each) do
        login_user(admin)
      end

      it "creates a new Product" do
        expect {
          post :create, {:product => valid_attributes}, valid_session
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes}, valid_session
        assigns(:product).should be_a(Product)
        assigns(:product).should be_persisted
      end

      it "redirects to the created product" do
        post :create, {:product => valid_attributes}, valid_session
        response.should redirect_to admin_products_path
      end
    end

    describe "with invalid params" do
      it "does not create a product" do
        Product.any_instance.stub(:save).and_return(false)
        post :create, {:product => { "name" => "invalid value" }}, valid_session
        expect(Product.count).to eq 0
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "assigns the requested product as @product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        assigns(:product).should eq(product)
      end

      it "redirects to the product" do
        put :update, {:id => product1.to_param, :product => valid_attributes}, valid_session
        response.should redirect_to admin_products_path(product1)
      end
    end

    describe "with invalid params" do
      it "assigns the product as @product" do
        Product.any_instance.stub(:save).and_return(false)
        put :update, {:id => product1.to_param, :product => { "name" => "invalid value" }}, valid_session
        expect(product1.name).to eq "product_name"
      end
    end
  end

  describe "DELETE destroy" do
    before (:each) do
      login_user(admin)
    end

    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete :destroy, {:id => product.to_param}, valid_session
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      delete :destroy, {:id => product1.to_param}, valid_session
      response.should redirect_to admin_products_path
    end
  end

  describe "GET index" do
    it "assigns the requested product as @product" do
      get :index
    end
  end

  describe "retire and unretire" do
    before (:each) do
      login_user(admin)
    end

    it "retires a product" do
      product = Product.create! valid_attributes
      put :retire, {id: product.id}
      expect(product.retired).to eq false
    end

    it "unretires a product" do
      product = Product.create! valid_attributes
      put :unretire, {id: product.id}
      expect(product.retired).to eq false
    end
  end
end


