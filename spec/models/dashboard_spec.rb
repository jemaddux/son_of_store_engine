require 'spec_helper'

describe Dashboard do
  it "product" do
    Product.create(name: "product", store_id: 1)
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
    Category.create(name: "category", store_id: 1)
    dashboard = Dashboard.new("1")
    expect(dashboard.categories.first.name).to eq "category"
    expect(dashboard.categories.first.store_id).to eq 1
  end

  it "retired_products" do
    product = Product.create(name: "product", store_id: 1)
    product.retired = true
    product.save
    dashboard = Dashboard.new("1")
    expect(dashboard.retired_products.first.name).to eq "product"
    expect(dashboard.retired_products.first.store_id).to eq 1
  end  
end
