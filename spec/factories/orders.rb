FactoryBot.define do
  factory :order do
    product_id { 1 }
    user_id { 1 }
    status { "MyString" }
    token { "MyString" }
    charge_id { "MyString" }
    error_message { "MyString" }
    customer_id { "MyString" }
    payment_gateway { 1 }
  end
end
