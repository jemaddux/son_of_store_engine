require 'spec_helper'

describe OrderProcessor do

  let(:cart){FactoryGirl.create(:cart)}

  describe "destroy current session" do 

    context "given an order has been placed" do 
      it "destroys the current session for that cart" do 

        current_session = cart.session

        OrderProcessor.destroy_current_session!(cart.id, cart.session)
        expect(current_session.carts.find_by_id(cart.id)).to be_nil
      end
    end
  end
end 