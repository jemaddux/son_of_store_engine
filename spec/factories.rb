FactoryGirl.define do 

  sequence :email do |n|
    "person#{n}@test.com"
  end

  factory :product do 
    name "product_name"
    description "a_description"
    price 2.00
    retired false 
  end 

  factory :user do 
    full_name "user"
    email 
    role "user"
    password "password"
  end 

  # factory :admin, class User do 
  #   full_name "user"
  #   email "test@test.com"
  #   role admin 
  # end 

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
end 

