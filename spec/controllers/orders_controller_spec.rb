require 'spec_helper'

describe OrdersController do
  let(:user) {FactoryGirl.create(:user)}
  let(:product) {FactoryGirl.create(:product)}
  let(:cart) {FactoryGirl.create(:cart)}


  def valid_attributes
    { "status" => "pending", "user_id" => user.id, "total_cost" => 300, card_number: '4242424242424242' }
  end

   def valid_attributes1
    { "status" => "pending", "user_id" => user.id, "total_cost" => 500, card_number: '4242424242424242' }
  end


  def checkout_with_addresses
    { "user_email" => "email@email.test",
      "card_number" => '4242424242424242',
      "shipping_street_name" => "Mallory Lane", 
      "shipping_city" => "Denver", 
      "shipping_state" => "Colorado", 
      "shipping_zipcode" => "80204", 
      "billing_street_name" => "Mallory Lane", 
      "billing_city" => "Denver", 
      "billing_state" => "Colorado", 
      "billing_zipcode" => "80204",
      order: { "store_id" => cart.store_id }
    }
  end

  def checkout_with_logged_in_user_addresses
    { "card_number" => '4242424242424242',
      "shipping_street_name" => "Mallory Lane", 
      "shipping_city" => "Denver", 
      "shipping_state" => "Colorado", 
      "shipping_zipcode" => "80204", 
      "billing_street_name" => "Mallory Lane", 
      "billing_city" => "Denver", 
      "billing_state" => "Colorado", 
      "billing_zipcode" => "80204",
      order: { "store_id" => cart.store_id }
    }
  end


  describe "a user checks out" do

    describe "with valid params and logged out" do 

      before do 
        o = cart.add_product(product)
        o.save!
        ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
      end 

      context "a user checks out but does not sign up" do 

        it "is invalid if the user does not submit an email" do 
          post :create,  card_number: '4242424242424242', order: { "store_id" => cart.store_id }
          expect(Order.count).to eq 0
          expect(response).to render_template("new")
        end

        it "validates that the user has entered a valid email" do 
          pending
          post :create,  card_number: '4242424242424242', user_email: "not_a_valid_email", order: { "store_id" => cart.store_id }
          expect(Order.count).to eq 0
        end 

        it "allows that user to check out" do 
          post :create,  card_number: '4242424242424242', user_email: "email@email.test", order: { "store_id" => cart.store_id }
          expect(Order.count).to eq 1
        end 

        it "starts the background worker to send the email as a background process" do 
          (Resque).should_receive(:enqueue)
          post :create,  card_number: '4242424242424242', user_email: "email@email.test", order: { "store_id" => cart.store_id }
        end
      end 

      context "a user that is not logged in submits their billing info" do 

        it "has an order with that shipping and billing id" do 
          post :create,  checkout_with_addresses
          expect(Order.count).to eq 1
          expect(Order.first.shipping_id).to_not eq nil
          expect(Order.first.billing_id).to_not eq nil
          expect(CustomerAddress.count).to eq 2
        end
      end 

      describe "given an order has been placed" do 

        before do 
          post :create,  checkout_with_addresses
          ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
          OrdersController.any_instance.stub(:find_cart).and_return(cart)
        end

        it "generate a unique hashed url" do 
          expect(Order.first.confirmation_hash).to_not eq nil 
        end 

        it "allows that user to visit that url to see their order" do 
          conf_hash = Order.first.confirmation_hash
          get  :display, { confirmation_hash: conf_hash.to_s }
          expect(assigns(:order)).to eq Order.first
        end 

        it "redirects to this url after their order has been placed" do 
          order = Order.first
          expect(response).to redirect_to(display_path(order.confirmation_hash))
        end 
      end 
    end 


    describe "with valid params and logged in" do
      before do
        login_user(user)
        o = cart.add_product(product)
        o.save!
        ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
      end

      it "allows that person to check out" do 
        post :create,   card_number: '4242424242424242', order: { "store_id" => cart.store_id }
        expect(Order.find_all_by_user_id(user.id).count).to eq 1
      end

      context "a user that is logged in submits their billing info" do 

        it "has an order with that shipping and billing id" do 
          post :create,  checkout_with_logged_in_user_addresses
          expect(Order.count).to eq 1
          expect(Order.first.shipping_id).to_not eq nil
          expect(Order.first.billing_id).to_not eq nil
          expect(CustomerAddress.count).to eq 2
        end
      end  
    end


### User 

  describe "when a user visits their orders index" do

    before (:each) do 
      ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
    end

    it "assigns all orders as @orders" do
      pending "need to add validation for this index, will be specific to each user"
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

    before (:each) do 
      ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
    end

    it "new order without items redirects" do
      get :new, store_id: cart.store_id
      response.should redirect_to(root_path)
    end
  end


    describe "with invalid params" do
      before(:each) do
        login_user(user)
      end

      it "re-renders the 'new' template" do
        Order.any_instance.stub(:valid?).and_return(false)
        post :create, { "status" => "invalid value", order: { "store_id" => cart.store_id } }
        response.should render_template("new")
      end
    end
  end
end
