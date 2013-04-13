FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@test.com"
  end

  sequence :name do |n|
    "unique_store_#{n}"
  end

  sequence :path do |n|
    "unique_store_#{n}"
  end

  factory :store do
    name
    description "This is a description"
    path
  end

  factory :product do
    name "product_name"
    description "a_description"
    price 2.00
    retired false
  end

  factory :category do
    name "new category"
  end

  factory :user do
    full_name "user"
    email
    role "user"
    password "password"
  end

  factory :super_admin, class: User do
    full_name "user"
    email "test@test.com"
<<<<<<< HEAD
    role "superuser"
=======
    role "platform_admin"
>>>>>>> ec6638d9a0b5bbf5994db0266e1597aaec66b50e
    password "password"
  end

  factory :admin, class: User do
    full_name "a name"
    email "test2@test.com"
    role "admin"
    password "password"
  end

  factory :order do
    user
    status 'pending'
    total_cost 500
    card_number '4242424242424242'
  end

  factory :cart do
  end

  factory :line_item do
    product
    cart
    user
  end

  factory :billing_address, class: CustomerAddress do
    street_name "Mallory Lane"
    city "Denver"
    state "Colorado"
    zipcode "80204"
    address_type "billing"
  end

   factory :shipping_address, class: CustomerAddress do
    street_name "Mallory Lane"
    city "Denver"
    state "Colorado"
    zipcode "80204"
    address_type "shipping"
  end
end




