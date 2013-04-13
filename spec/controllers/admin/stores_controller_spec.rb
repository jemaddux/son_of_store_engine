require 'spec_helper'

describe Admin::StoresController do 

  def valid_attributes
    { "name" => "MyString" }
  end

  def valid_session
    {}
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
      store = Store.create! valid_attributes
      user = User.create(role: "platform_admin")
      store.user_id = user.id
      store.status = "pending"
      put :change_status, {:store => "someStore", :store => "somePath", :id => 1, :status => "live" }, valid_session
    end

    it "updates the requested store" do
      store = Store.create! valid_attributes
      store.status = "pending"
      put :change_status, {:store => "someStore", :store => "somePath", :id => 1, :status => "declined" }, valid_session
      expect redirect_to "/admin/stores"
    end
  end
end 
