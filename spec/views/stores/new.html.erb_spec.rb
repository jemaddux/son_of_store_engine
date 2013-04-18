require 'spec_helper'

describe "stores/new" do
  before(:each) do
    assign(:store, stub_model(Store,
      :name => "MyString",
      :path => "MyString"
    ).as_new_record)
  end

  
end
