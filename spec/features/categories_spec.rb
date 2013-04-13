require 'spec_helper'

describe "Categories" do
  include_context "standard test dataset"
  let!(:user) {FactoryGirl.create(:user)}
  let(:super_admin) {FactoryGirl.create(:super_admin)}
  let(:admin) {FactoryGirl.create(:admin)}


    before (:each) do
      # visit '/login'
      # fill_in 'email', with: 'admin@oregonsale.com'
      # fill_in 'password', with: 'password'
      # click_button "Log in"
    end

   

  describe "given a regular user visits this site" do

    before (:each) do
      # visit '/login'
      # fill_in 'email', with: 'admin@oregonsale.com'
      # fill_in 'password', with: 'password'
      # click_button "Log in"
    end

    it "/categories" do
      pending
    end

    it 'categories/new' do
      pending
    end
  end

  describe "given a super admin visits this site" do 

    before (:each) do
      # visit '/login'
      # fill_in 'email', with: 'admin@oregonsale.com'
      # fill_in 'password', with: 'password'
      # click_button "Log in"
    end

    it "/categories" do
      pending
    end

    it 'categories/new' do
      pending
    end
  end

  describe "given an admin visits this site" do 

    before (:each) do
      # visit '/login'
      # fill_in 'email', with: 'admin@oregonsale.com'
      # fill_in 'password', with: 'password'
      # click_button "Log in"
    end

    it "/categories" do
      pending
    end

    it 'categories/new' do
      pending
    end
  end

end