json.extract! product, :id, :name, :stripe_plan_name, :paypal_plan_name, :created_at, :updated_at
json.url product_url(product, format: :json)
