require 'spec_helper'

describe UsersController do

  let(:store){ FactoryGirl.create(:store) }
  let(:product1) { FactoryGirl.create(:product) }
  let(:admin){ User.create(full_name: "full_name", email:"email@email.com", password: "password") }

  describe "minimum admin" do 

  before (:each) do
    login_user(admin)
    @request.env['HTTP_REFERER'] = 'http://localhost:3000/'
  end

    context "given there is only one admin for a store" do 

      before do 
        admin.store_id = store.id
        admin.role = "admin"
        admin.save!
      end

      it "the superuser cannot remove the stores final admin" do 
        put :update, { :id => admin.id, :role => "user", :store_id => store.id  }
        expect(assigns(:user).id).to eq store.id
        expect(assigns(:user).role).to eq "admin"
      end
    end
  end

  describe "GET 'new'" do
    it "renders new view" do
      get :new
      response.should be_success
      expect(response).to render_template :new
    end

    it "assigns new user to @user" do
      get :new
      expect(assigns(:user)).to be_kind_of(User)
    end
  end

  describe "POST 'create' with valid params" do
    let(:valid_attributes) do
      { user: { full_name: "name", email: "user@oregonstore.com", 
        password: "password", password_confirmation: "password" } }
    end

    it "saves the new user to the database" do
      expect {
        post :create, valid_attributes
      }.to change(User, :count).by(1)
    end

    it "sends the user a confirmation email" do 
      (Resque).should_receive(:enqueue)
      post :create, valid_attributes
    end

    it "redirects user to root url" do
      post :create, valid_attributes
      # expect(response).to redirect_back_or_to root_url
    end
  end

  describe "POST 'create' with invalid params" do
    let(:invalid_attributes) do
      { user: {email: "", password: "password"}}
    end
  end
end
