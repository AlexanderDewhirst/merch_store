require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        product_id: 2,
        user_id: 3,
        status: "Status",
        token: "Token",
        charge_id: "Charge",
        error_message: "Error Message",
        customer_id: "Customer",
        payment_gateway: 4
      ),
      Order.create!(
        product_id: 2,
        user_id: 3,
        status: "Status",
        token: "Token",
        charge_id: "Charge",
        error_message: "Error Message",
        customer_id: "Customer",
        payment_gateway: 4
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Status".to_s, count: 2
    assert_select "tr>td", text: "Token".to_s, count: 2
    assert_select "tr>td", text: "Charge".to_s, count: 2
    assert_select "tr>td", text: "Error Message".to_s, count: 2
    assert_select "tr>td", text: "Customer".to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
  end
end
