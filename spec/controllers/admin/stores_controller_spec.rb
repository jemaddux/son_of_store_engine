require 'spec_helper'

describe Admin::StoresController do 

  let(:super_admin){FactoryGirl.create(:super_admin)}
  let(:store){FactoryGirl.create(:store)}
  let(:user){FactoryGirl.create(:user)}

  before(:each) do 
    login_user(super_admin)
  end

  def valid_attributes
    { "name" => "MyString" }
  end

  def valid_session
    {}
  end

  describe "given a super admin reviewes a request for a new store" do 

    before do 
    store.user_id = user.id
    store.save! 
    end

    context "the admin approves the new store" do 

      it "sends an email to the store admin" do 
        (Resque).should_receive(:enqueue)
        post :change_status, {id: store.id, status: "live"}
      end
    end

    context "the admin denies the new store" do 
      it "sends an email to the store admin" do 
        (Resque).should_receive(:enqueue)
        post :change_status, {id: store.id, status: "declined"}
      end
    end
  end

  describe "GET show" do
    it "assigns the requested store as @store" do
      store = Store.create! valid_attributes
      get :index, {:id => store.to_param}, valid_session
      expect redirect_to "/"
    end
  end

  describe "PUT update" do  
    it "updates the requested store" do
      pending
      store = Store.create! valid_attributes
      user = User.create(role: "platform_admin")
      store.user_id = user.id
      store.status = "pending"
      put :change_status, {:store => "someStore", :store => "somePath", :id => 1, :status => "live" }, valid_session
    end

    it "updates the requested store" do
      pending
      store = Store.create! valid_attributes
      store.status = "pending"
      put :change_status, {:store => "someStore", :store => "somePath", :id => 1, :status => "declined" }, valid_session
      expect redirect_to "/admin/stores"
    end
  end
end 
