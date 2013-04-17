require 'spec_helper'

describe Admin::AdminController do 

  let(:store){ FactoryGirl.create(:store) }
  let(:product1) { FactoryGirl.create(:product) }
  let(:admin){ User.create(full_name: "full_name", email:"email@email.com", password: "password") }
  let!(:user){FactoryGirl.create(:user)}

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
        admin_2 = User.create( full_name: "full_name", 
                              email:"email_2@email.com", 
                              password: "password",
                              role: "admin",
                              store_id: store.id )

        put :remove, { :id => admin_2.id, :role => "user" }
        expect(assigns(:user).role).to eq "user"
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