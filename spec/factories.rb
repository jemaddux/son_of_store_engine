FactoryGirl.define do 

  factory :product do 
    name "product_name"
    description "a_description"
    price 2.00
    retired false 
  end 

  factory :user do 
    full_name "user"
    email "test@test.com"
  end 

  # factory :admin, class User do 
  #   full_name "user"
  #   email "test@test.com"
  #   role admin 
  # end 

  factory :order do
    status "paid"
    total_cost 25.00 
    user
    confirmation_code
  end 

  factory :cart do 
  end 

  factory :line_item do 
    product
    cart
    user 
  end 
end 

