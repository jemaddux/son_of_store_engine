require 'spec_helper'

describe ProductsController do


  let(:product) {FactoryGirl.create(:product)}


  describe "given a user wants to view a product" do 

    it "renders the product show page" do 
      get :show, {id: product.to_param}
      expect(assigns(:product)).to eq product
    end
  end

end 