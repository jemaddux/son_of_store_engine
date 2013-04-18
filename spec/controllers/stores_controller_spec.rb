require 'spec_helper'

describe StoresController do

  def valid_attributes
    { "name" => "MyString" }
  end

  def valid_session
    {}
  end

  describe "an admin updates a store's details" do 

    let(:store){FactoryGirl.create(:store)}

    it "updates the details of that store" do 
      pending
      put :update, {name: "a name"}
      expect(Store.first.name).to eq "a name"
    end
  end

  describe "get suggested stores and store listing" do 
    let!(:store_1){ FactoryGirl.create(:store)}
    let!(:store_2){ FactoryGirl.create(:store)}
    let!(:store_3){ FactoryGirl.create(:store)}
    let!(:store_4){ FactoryGirl.create(:store)}

    context "given a user goes to visit a a store that does not exist" do 
      it "redirects to a list of suggested stores" do 
        get :show, {:status => "live", :store_id => 400}, valid_session
        expect(response).to render_template("suggested")
        expect(assigns(:stores)).to_not be_nil 
      end
    end

    context "given a user clicks to see a list of all stores" do 
      it "redirects to a list of all stores" do 
        get :store_listing
        expect(assigns(:stores)).to eq Store.all
      end
    end
  end

  describe "get pending stores" do 
    it "renders pending" do 
      store = FactoryGirl.create(:store)
      get :pending, path: store.path
    end
  end

  describe "store show" do

    let!(:store_1){ FactoryGirl.create(:store)}
    let!(:category){FactoryGirl.create(:category)}

    before do 
      category.store_id = store_1.id 
      category.save!
    end

    it "assigns the requested store as @store" do
      get :show, {:status => store_1.status, :store_id => store_1.path}, valid_session
      assigns(:store).should eq(store_1)
    end
  end

  describe "new store" do
    it "assigns a new store as @store" do
      get :new, {}, valid_session
      assigns(:store).should be_a_new(Store)
    end
  end

  describe "edit" do
    it "assigns the requested store as @store" do
      store = Store.create! valid_attributes
      get :edit, {:id => store.to_param}, valid_session
      assigns(:store).should eq(store)
    end
  end

  describe "create" do
    describe "with valid params" do
      it "creates a new Store" do
        expect {
          post :create, {:store => valid_attributes}, valid_session
        }.to change(Store, :count).by(1)
      end

      it "assigns a newly created store as @store" do
        post :create, {:store => valid_attributes}, valid_session
        assigns(:store).should be_a(Store)
        assigns(:store).should be_persisted
      end

      it "redirects to the created store" do
        post :create, {:store => valid_attributes}, valid_session
        response.should redirect_to("http://test.host/stores/pending/")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved store as @store" do
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        assigns(:store).should be_a_new(Store)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Store.any_instance.stub(:save).and_return(false)
        post :create, {:store => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "destroy" do
    it "destroys the requested store" do
      store = Store.create! valid_attributes
      expect {
        delete :destroy, {:id => store.to_param}, valid_session
      }.to change(Store, :count).by(-1)
    end
  end
end
