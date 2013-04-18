require 'spec_helper'

describe "Categories" do
  include_context "standard test dataset"
  let!(:user) {FactoryGirl.create(:user)}
  let(:super_admin) {FactoryGirl.create(:super_admin)}
  let(:admin) {FactoryGirl.create(:admin)}


end
