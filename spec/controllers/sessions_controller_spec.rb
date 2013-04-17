require 'spec_helper'

describe SessionsController do 

  let(:admin){FactoryGirl.create(:admin)}
  let(:user){ FactoryGirl.create(:user)}

  def default_url_options
    {:host => 'test.host'}
  end

  describe "create" do
    it "redirects back if role is user" do
      session[:return_to_url] = 'http://example.com/'
      @controller.should_receive(:login).with('email', 'password', nil) do
        user = double
        user.stub(:role?).with(:user) { true }
        user
      end
      post :create, :email => "email", :password => "password"
      expect(response).to redirect_to 'http://example.com/'
    end

    it "renders new if create called without a user" do
      post :create
      expect(response).to render_template("new")
    end
  end

  describe 'destroy' do
    before (:each) do 
      login_user(admin)
    end

    it "should logout" do
      @controller.should_receive(:logout)
      delete :destroy
    end

    it "should redirect to root" do
      delete :destroy
      expect(response).to redirect_to(root_url)
    end

    it "should set user_session_id to nil" do
      session[:user_session_id] = 1
      delete :destroy
      expect(session[:user_session_id]).to eq(nil)
    end
  end

  it 'should set @redirect on get to new' do
    get :new, :redirect => 'http://redirect.here'
    expect(assigns(:redirect)).to eq 'http://redirect.here'
  end
end
