require 'spec_helper'

describe SessionsController do 

  let(:admin){FactoryGirl.create(:admin)}
  let(:user){ FactoryGirl.create(:user)}

  before (:each) do 
    login_user(admin)
    @request.env['HTTP_REFERER'] = 'http://localhost:3000/'
  end

  it "can create without user" do
    post :create
    expect(response).to render_template("new")
  end

  it "can create with a user" do
  end
end
