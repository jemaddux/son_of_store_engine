require 'spec_helper'

describe LineItemsController do

  before (:each) do 
    @request.env['HTTP_REFERER'] = 'http://localhost:3000/'
  end

  let(:product){ FactoryGirl.create(:product)}
  let(:product_2){FactoryGirl.create(:product)}


  def valid_attributes
    { product_id: product.id, cart_id: cart.id }
  end

  describe "a user clicks to purchase an item" do

    before (:each) do
      post :create, {product_id: product.id, store_id: product.store_id}
    end

    it "creates a cart for the store that the user is shopping at" do 
      expect(Session.count).to eq 1
      expect(Cart.count).to eq 1
      expect(Cart.first.session_id).to eq 1
      expect(Cart.first.store_id).to eq 1
      expect(Cart.first.line_items.count).to eq 1
    end

    it "saves that product to the cart" do
      expect(Cart.first.line_items.first.product_id).to eq product.id
    end
  end 

  describe "a user wants to check out from a particular store" do 

    before (:each) do 
      post :create, {product_id: product.id}
      post :create, {product_id: product_2.id}
    end

    it "allows the user to check out products for only that store" do 
      expect(Session.count).to eq 1
      expect(Cart.count).to eq 2
      expect(Cart.first.line_items.count).to eq 1
      expect(Cart.last.line_items.count).to eq 1
    end 
  end

  describe "with valid params" do
    it "creates a new LineItem" do
      expect {
        post :create, {product_id: product.id}
      }.to change(LineItem, :count).by(1)
    end

    it "assigns a newly created line_item as @line_item" do
      post :create, {product_id: product.id}
      assigns(:line_item).should be_a(LineItem)
      assigns(:line_item).should be_persisted
    end

    it "redirects to the created line_item" do
      post :create, {product_id: product.id}
      response.should redirect_to("http://localhost:3000/")
    end
  end

  describe "with invalid params" do
    it "assigns a newly created but unsaved line_item as @line_item" do
      LineItem.any_instance.stub(:save).and_return(false)
      post :create, { "product_id" => product.id }
      assigns(:line_item).should be_a_new(LineItem)
    end

    it "re-renders the 'new' template" do
      LineItem.any_instance.stub(:save).and_return(false)
      post :create, { "product_id" => product.id }
      response.should render_template("new")
    end
  end


  describe "DELETE destroy" do

    before (:each) do 
      post :create, {product_id: product.id}
    end
    it "destroys the requested line_item" do
      line_item = LineItem.first
      expect {
        delete :destroy, {:id => line_item.to_param}
      }.to change(LineItem, :count).by(-1)
    end
  end

  describe "PUT commands" do
    before (:each) do
      post :create, {product_id: product.id}
    end

    describe "quantity" do
      it "increases quantity" do
        put :increase, :id => 1
      end

      it "decreases quantity" do
        put :increase, :id => 1
        put :decrease, :id => 1
      end

      it "deletes quantity" do
        put :decrease, :id => 1
      end
    end
  end
end
