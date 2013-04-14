require 'spec_helper'

describe CartsController do

  let!(:cart_2) {FactoryGirl.create(:cart_2)}

  def valid_session
    {}
  end

  def valid_attributes
    {}
  end

  describe "GET index" do

    let!(:cart){ FactoryGirl.create(:cart)}

    before (:each) do 
      ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
    end

    it "assigns all carts as @carts" do
      get :index, {}, valid_session
      assigns(:carts).should eq([cart])
    end
  end

  describe "GET show" do

    let!(:cart){ FactoryGirl.create(:cart)}

    before (:each) do 
      ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
    end

    it "assigns the requested cart as @cart" do
      get :show, {:id => cart.to_param, store_id: cart.store_id}, valid_session
      assigns(:cart).should eq([cart])
    end
  end

  describe "GET new" do
    it "assigns a new cart as @cart" do
      get :new, {}, valid_session
      assigns(:cart).should be_a_new(Cart)
    end
  end

  describe "GET edit" do

    let!(:cart){ FactoryGirl.create(:cart)}

    it "assigns the requested cart as @cart" do
      get :edit, {:id => cart.to_param}, valid_session
      assigns(:cart).should eq(cart)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cart" do
        expect {
          post :create, {:cart => valid_attributes}, valid_session
        }.to change(Cart, :count).by(1)
        expect(Cart.first.session_id).to eq 1
      end

      it "assigns a newly created cart as @cart" do
        post :create, {:cart => valid_attributes}, valid_session
        assigns(:cart).should be_a(Cart)
        assigns(:cart).should be_persisted
      end

      it "redirects to the created cart" do
        post :create, {:cart => valid_attributes}, valid_session
        response.should redirect_to(Cart.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cart as @cart" do
        Cart.any_instance.stub(:save).and_return(false)
        post :create, {:cart => {  }}, valid_session
        assigns(:cart).should be_a_new(Cart)
      end

      it "re-renders the 'new' template" do
        Cart.any_instance.stub(:save).and_return(false)
        post :create, {:cart => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do

    let!(:cart){ FactoryGirl.create(:cart)}

    describe "with valid params" do
      it "updates the requested cart" do
        Cart.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => cart.to_param, :cart => { "these" => "params" }}, valid_session
      end

      it "assigns the requested cart as @cart" do
        put :update, {:id => cart.to_param, :cart => valid_attributes}, valid_session
        assigns(:cart).should eq(cart)
      end

      it "redirects to the cart" do
        put :update, {:id => cart.to_param, :cart => valid_attributes}, valid_session
        response.should redirect_to(cart)
      end
    end

    describe "with invalid params" do

      let!(:cart){ FactoryGirl.create(:cart)}

      it "assigns the cart as @cart" do
        Cart.any_instance.stub(:save).and_return(false)
        put :update, {:id => cart.to_param, :cart => {  }}, valid_session
        assigns(:cart).should eq(cart)
      end

      it "re-renders the 'edit' template" do
        Cart.any_instance.stub(:save).and_return(false)
        put :update, {:id => cart.to_param, :cart => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  # describe "DELETE destroy" do
  #   it "destroys the requested cart" do
  #     cart = Cart.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => cart.to_param}, valid_session
  #     }.to change(Cart, :count).by(-1)
  #   end

  #   it "redirects to the carts list" do
  #     cart = Cart.create! valid_attributes
  #     delete :destroy, {:id => cart.to_param}, valid_session
  #     response.should redirect_to(carts_path)
  #   end
  # end

end
