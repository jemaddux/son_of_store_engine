require 'spec_helper'

describe CustomerAddress do

  let(:shipping){FactoryGirl.build(:shipping_address)}
  let(:billing){FactoryGirl.build(:billing_address)}
  let(:user) {FactoryGirl.create(:user)}

  describe "creating a new shipping address and a user that is logged in" do 

    # before do 
    #   login_user(user)
    # end 

    context "given valid params" do 
      it "creates a new shipping address" do 
        shipping.save!
        expect(CustomerAddress.count).to eq 1
        expect(CustomerAddress.first.address_type).to eq "shipping"
      end 
    end 
  end 

  describe "creating a new shipping address and a user that is not logged in" do 

    context "given valid params" do 
      it "creates a new shipping address" do 
        billing.save!
        expect(CustomerAddress.count).to eq 1
        expect(CustomerAddress.first.address_type).to eq "billing"
      end 
    end 
  end 
end 