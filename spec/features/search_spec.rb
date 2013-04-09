require 'spec_helper'

describe "Products" do
  include_context "standard test dataset"
  let!(:u1) {User.create full_name: "admin",
          email: 'admin@oregonsale.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'admin'}

  describe "GET /products", js: true do
    before (:each) do
      visit '/login'
      fill_in 'email', with: 'admin@oregonsale.com'
      fill_in 'password', with: 'password'
      click_button "Log in"
    end
  end
end
