require 'spec_helper'

describe Dashboard do

  let(:store){FactoryGirl.create(:store)}
  let!(:order){Order.create(status: "pending", user_id: 1, total_cost: 3372, card_number: '4242424242424242', store_id: store.id)}

  it "product" do
    Product.create(name: "product", store_id: store.id)
    dashboard = Dashboard.new("1")
    expect(dashboard.products.first.name).to eq "product"
    expect(dashboard.products.first.store_id).to eq 1
  end

  it "statuses" do
    dashboard = Dashboard.new("1")
    expect(dashboard.statuses).to eq ["pending", "cancelled", "paid", 
      "shipped", "returned"]
  end

  it "categories" do
    Category.create(name: "category", store_id: store.id)
    dashboard = Dashboard.new("1")
    expect(dashboard.categories.first.name).to eq "category"
    expect(dashboard.categories.first.store_id).to eq 1
  end

  it "retired_products" do
    product = Product.create(name: "product", store_id: store.id)
    product.retired = true
    product.save
    dashboard = Dashboard.new("1")
    expect(dashboard.retired_products.first.name).to eq "product"
    expect(dashboard.retired_products.first.store_id).to eq 1
  end  

  it "finds the stores orders" do 
    dashboard = Dashboard.new("1")
    expect(dashboard.store_orders).to eq [order]
  end
end
