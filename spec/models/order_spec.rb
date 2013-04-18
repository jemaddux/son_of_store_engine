require 'spec_helper'

describe Order do
  include_context "standard test dataset"
  let!(:new_user){FactoryGirl.build(:user)}
  let!(:order){Order.create(status: "pending", user_id: 1, total_cost: 3372, card_number: '4242424242424242')}
  let(:store){FactoryGirl.create(:store)}
  let!(:li){LineItem.create(product_id: 1, cart_id: nil,
  order_id: 1, quantity: 3, price: 24)}

  describe 'add_line_items' do
    it "adds order id to each line_item in a cart at checkout" do
      cart = Cart.create
      order.add_line_items(cart)
      order.line_items
    end
  end

  describe "generate random" do
    it "generates random thing" do
      a = order.generate_confirmation_code
      (order.generate_confirmation_code).should_not eq a
    end
  end

  describe "store id with an order" do 

    it "order is associated with a particular store" do 
      order.store_id = store.id
      expect(order.store_id).to_not be_nil
    end
  end 

  describe "validate credit cart" do 

    let(:order){ FactoryGirl.build(:order) }

    context "an invalid credit cart has been entered" do 

      before do 
        order.card_number = "345"
        order.save
      end

      it "does not save the order" do 
        expect(Order.count).to eq 0
      end
    end

    context "no credit card has been entered" do 

      before do 
        order.card_number = ""
        order.save
      end

      it "does not save the order" do 
        expect(Order.count).to eq 0
      end
    end

    context "a valid credit card has been entered" do 

      before do 
        order.card_number = "4242424242424242"
        order.save
      end

      it "saves the order" do 
        expect(Order.count).to eq 1
      end
    end

    describe "create from cart from user" do 

      let(:line_item){FactoryGirl.create(:line_item)}
      let(:shipping_address){FactoryGirl.create(:shipping_address)}
      let(:billing_address){FactoryGirl.create(:billing_address)}

      it "creates an order for the user from that cart" do 

        Order.create_from_cart_for_user(line_item.cart, 1, '4242424242424242', shipping_address.id, billing_address.id, line_item.cart.store_id)
        expect(Order.count).to eq 1
      end
    end

    describe "update an order status" do 

      let(:order){FactoryGirl.create(:order)}

      it "upates that orders status" do 
        order.update_status("cancelled")
        expect(order.status).to eq "cancelled"
      end
    end
  end
end
