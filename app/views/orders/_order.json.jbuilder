json.extract! order, :id, :product_id, :user_id, :status, :token, :charge_id, :error_message, :customer_id, :payment_gateway, :created_at, :updated_at
json.url order_url(order, format: :json)
