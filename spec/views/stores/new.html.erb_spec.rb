require 'spec_helper'

describe "stores/new" do
  before(:each) do
    assign(:store, stub_model(Store,
      :name => "MyString",
      :path => "MyString"
    ).as_new_record)
  end

  it "renders new store form" do
    pending
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", stores_path, "post" do
      assert_select "input#store_name[name=?]", "store[name]"
      assert_select "input#store_path[name=?]", "store[path]"
    end
  end
end
