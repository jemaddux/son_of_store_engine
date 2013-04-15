require 'spec_helper'

describe Admin::AdminController do 

  let(:admin){FactoryGirl.create(:admin)}
  let(:user){ FactoryGirl.create(:user)}

  before (:each) do 
    login_user(admin)
    @request.env['HTTP_REFERER'] = 'http://localhost:3000/'
  end

  context "when an admin creates a new admin that does not exist" do 

    it "sends that new admin an email" do 
      (Resque).should_receive(:enqueue)
      post :new_admin, {commit: "Create New Admin", email: "test@test.xkcd", store_id: admin.store_id}
    end
  end


  context "when an admin creates a new admin that does exist" do 

    it "sends that new admin an email" do 
      (Resque).should_receive(:enqueue)
      post :new_admin, {commit: "Create New Admin", email: user.email, store_id: admin.store_id}
    end
  end
end 