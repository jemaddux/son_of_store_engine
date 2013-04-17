require 'spec_helper'

describe Admin::AdminController do 

  let(:store){ FactoryGirl.create(:store) }
  let(:product1) { FactoryGirl.create(:product) }
  let(:admin){ User.create(full_name: "full_name", email:"email@email.com", password: "password") }
  let!(:user){FactoryGirl.create(:user)}

  describe "minimum admin" do 

  before (:each) do
    admin.store_id = store.id
    admin.role = "admin"
    admin.save!
    login_user(admin)
    @request.env['HTTP_REFERER'] = 'http://localhost:3000/'
  end

    context "given there is only one admin for a store" do 
      it "the superuser cannot remove the stores final admin" do 
        put :remove, { :id => admin.id, :role => "user" }
        # expect(assigns(:user).id).to_not eq store.id
        expect(assigns(:user).role).to eq "admin"
      end
    end

    context "given there are multple admins for a store" do 
      before do 
        admin.store_id = store.id
        admin.role = "admin"
        admin.save!
      end

      it "the superuser can remove stores that have more than one admin" do 
        put :remove, { :id => admin.id }
        expect(admin.role).to eq "admin"
      end

      it "can create a new admin" do
        put :new_admin, {store_id: 1}
        put :new_admin, {store_id: 1, commit: "Create New Admin", 
                         email: "email@email.com"}
        expect(admin.role).to eq "admin"
      end

      it "create an admin" do
        put :create_admin, {store_id: 1, commit: "Create New Admin", 
                         email: "email@email.com"}
        expect(admin.role).to eq "admin"
      end

      it "signup an admin" do
        put :signup_admin, {store_id: 1, commit: "Create New Admin", 
                         email: "email@email.com"}
        expect(admin.role).to eq "admin"
      end

      it "the platform_admin can administer a store" do
        current_user = admin
        put :administer, {path: "oregonsale", store_id: 1}
      end
    end 
  end

  context "when an admin creates a new admin that does not exist" do 

    it "sends that new admin an email" do 
      #(Resque).should_receive(:enqueue)
      post :new_admin, {commit: "Create New Admin", email: "test@test.xkcd", store_id: admin.store_id}
    end
  end


  context "when an admin creates a new admin that does exist" do 

    it "sends that new admin an email" do 
      #(Resque).should_receive(:enqueue)
      post :new_admin, {commit: "Create New Admin", email: user.email, store_id: admin.store_id}
    end
  end
end 
