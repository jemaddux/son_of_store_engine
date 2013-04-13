require 'spec_helper'



describe Admin::OrdersController do 

  let(:user) {FactoryGirl.create(:super_admin)}
  let(:product) {FactoryGirl.create(:product)}
  let(:cart) {FactoryGirl.create(:cart)}

  def valid_attributes
    { "status" => "pending", "user_id" => user.id, "total_cost" => 300, card_number: '4242424242424242' }
  end

   def valid_attributes1
    { "status" => "pending", "user_id" => user.id, "total_cost" => 500, card_number: '4242424242424242' }
  end

  describe "when an admin goes to edit an order" do

    before (:each) do 
      login_user(user)
      ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
    end

    it "assigns the requested order as @order" do
      # order = FactoryGirl.create(:order)
      # get :edit, {:id => order.to_param, :order => { "status" => "MyString" }}
      # assigns(:order).should eq(order)
    end
  end

  describe "an admin updates an order" do

    before (:each) do 
      login_user(user)
      ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
    end

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
        # order = FactoryGirl.create(:order)
        # Order.any_instance.stub(:save).and_return(false)
        # put :update, {:id => order.to_param, :order => { "status" => "invalid value" }}
        # response.should render_template("edit")
      end
    end
  end  

  describe "DELETE destroy" do

    before (:each) do 
      login_user(user)
      ApplicationController.any_instance.stub(:current_session).and_return(cart.session)
    end

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
end 