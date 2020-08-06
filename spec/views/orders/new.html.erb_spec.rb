require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      product_id: 1,
      user_id: 1,
      status: "MyString",
      token: "MyString",
      charge_id: "MyString",
      error_message: "MyString",
      customer_id: "MyString",
      payment_gateway: 1
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input[name=?]", "order[product_id]"

      assert_select "input[name=?]", "order[user_id]"

      assert_select "input[name=?]", "order[status]"

      assert_select "input[name=?]", "order[token]"

      assert_select "input[name=?]", "order[charge_id]"

      assert_select "input[name=?]", "order[error_message]"

      assert_select "input[name=?]", "order[customer_id]"

      assert_select "input[name=?]", "order[payment_gateway]"
    end
  end
end
