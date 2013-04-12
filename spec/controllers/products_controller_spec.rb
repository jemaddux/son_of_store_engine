require 'spec_helper'

describe ProductsController do
  let(:store){ FactoryGirl.create(:store) }
  let(:product) { FactoryGirl.create(:product) }


  
  describe "when viewing products for a particular store" do 

    it "should display all products associated with that store" do 
    end
  end
end
