require 'spec_helper'

describe ApplicationHelper do

  context "given an existing cart" do 

    let(:cart){FactoryGirl.create(:cart)}

    it "finds the cost of a current cart" do 
      expect(cart_cost).to eq nil 
    end
  end

  context "if the user is authenticated" do

    let(:user){FactoryGirl.create(:admin)} 

    before do
      # login_user(user)
    end

    it "finds the current store id" do 
      pending
      expect(find_store_id_helper).to eq user.store_id
    end

  end

  it "know the states" do
    expect(us_states).to eq [['AK', 'AK'], ['AL', 'AL'], ['AR', 'AR'], ['AZ', 'AZ'], ['CA', 'CA'], ['CO', 'CO'], ['CT', 'CT'], ['DC', 'DC'], ['DE', 'DE'], ['FL', 'FL'], ['GA', 'GA'], ['HI', 'HI'], ['IA', 'IA'], ['ID', 'ID'], ['IL', 'IL'], ['IN', 'IN'], ['KS', 'KS'], ['KY', 'KY'], ['LA', 'LA'], ['MA', 'MA'], ['MD', 'MD'], ['ME', 'ME'], ['MI', 'MI'], ['MN', 'MN'], ['MO', 'MO'], ['MS', 'MS'], ['MT', 'MT'], ['NC', 'NC'], ['ND', 'ND'], ['NE', 'NE'], ['NH', 'NH'], ['NJ', 'NJ'], ['NM', 'NM'], ['NV', 'NV'], ['NY', 'NY'], ['OH', 'OH'], ['OK', 'OK'], ['OR', 'OR'], ['PA', 'PA'], ['RI', 'RI'], ['SC', 'SC'], ['SD', 'SD'], ['TN', 'TN'], ['TX', 'TX'], ['UT', 'UT'], ['VA', 'VA'], ['VT', 'VT'], ['WA', 'WA'], ['WI', 'WI'], ['WV', 'WV'], ['WY', 'WY']]
  end
end
