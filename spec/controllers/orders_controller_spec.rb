require 'spec_helper'

describe OrdersController do
  let(:user) {FactoryGirl.create(:user)}
  let(:product) {FactoryGirl.create(:product)}
  let(:cart) {FactoryGirl.create(:cart)}
  let(:shipping){ FactoryGirl.create(:shipping_address) }
  let(:billing){ FactoryGirl.create(:billing_address) }

  def valid_attributes
    { "status" => "pending", "user_id" => user.id, "total_cost" => 300, card_number: '4242424242424242' }
  end

   def valid_attributes1
    { "status" => "pending", "user_id" => user.id, "total_cost" => 500, card_number: '4242424242424242' }
  end

  describe "a user checks out" do

    describe "with valid params and logged out" do 

      before do 
        o = cart.add_product(product)
        o.save!
      end 
      
      context "a user enters their billing info but does not sign up" do 

        it "validates that the user has entered a valid email" do 
          pending
          post :create,  card_number: '4242424242424242', user_email: "not_a_valid_email"
          expect(Order.count).to eq 0
        end 

        it "allows that user to check out" do 
          post :create,  card_number: '4242424242424242', user_email: "email@email.test"
          expect(Order.count).to eq 1
        end 
      end 
    end 


    describe "with valid params and logged in" do
      before do
        login_user(user)
        o = cart.add_product(product)
        o.save!
      end

      it "allows that person to check out" do 
        post :create,   card_number: '4242424242424242' 
        expect(Order.find_all_by_user_id(user.id).count).to eq 1
      end 
    end



### Admin

  describe "when an admin goes to edit an order" do
    it "assigns the requested order as @order" do
      order = FactoryGirl.create(:order)
      get :edit, {:id => order.to_param}
      assigns(:order).should eq(order)
    end
  end

  describe "an admin updates an order" do
    describe "with valid params" do
      it "updates the requested order" do
        order = FactoryGirl.create(:order)
        Order.any_instance.should_receive(:update_attributes).with({ "status" => "MyString" })
        put :update, {:id => order.to_param, :order => { "status" => "MyString" }}
      end

      it "assigns the requested order as @order" do
        order = FactoryGirl.create(:order)
        put :update, {:id => order.to_param, :order => valid_attributes1 }
        assigns(:order).should eq(order)
      end

      it "redirects to the order" do
        order = Order.create!(valid_attributes)
        put :update, {:id => order.to_param, :order => valid_attributes1 }
        response.should redirect_to(order)
      end
    end

    describe "with invalid params" do
      it "assigns the order as @order" do
        order = FactoryGirl.create(:order)
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => { "status" => "invalid value" }}
        assigns(:order).should eq(order)
      end

      it "re-renders the 'edit' template" do
        order = FactoryGirl.create(:order)
        Order.any_instance.stub(:save).and_return(false)
        put :update, {:id => order.to_param, :order => { "status" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end  

  describe "DELETE destroy" do
    it "destroys the requested order" do
      order = FactoryGirl.create(:order)
      expect {
        delete :destroy, {:id => order.to_param}
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      order = FactoryGirl.create(:order)
      delete :destroy, {:id => order.to_param}
      response.should redirect_to(orders_path)
    end
  end




### User 

  describe "when a user visits their orders index" do
    it "assigns all orders as @orders" do
      order = FactoryGirl.create(:order)
      get :index, {}
      assigns(:orders).should eq([order])
    end
  end

  describe "when a user views a single order" do
    it "assigns the requested order as @order" do
      order = FactoryGirl.create(:order)
      get :show, {:id => order.to_param}
      assigns(:order).should eq(order)
    end
  end


  describe "GET new" do
    it "new order without items redirects" do
      get :new, {}, {}
      response.should redirect_to(root_path)
    end
  end



    describe "with invalid params" do
      before(:each) do
        login_user(user)
      end

      it "re-renders the 'new' template" do
        Order.any_instance.stub(:save).and_return(false)
        post :create, { "status" => "invalid value" }
        response.should render_template("new")
      end
    end
  end

end
