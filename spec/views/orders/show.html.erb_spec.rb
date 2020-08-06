require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      product_id: 2,
      user_id: 3,
      status: "Status",
      token: "Token",
      charge_id: "Charge",
      error_message: "Error Message",
      customer_id: "Customer",
      payment_gateway: 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Token/)
    expect(rendered).to match(/Charge/)
    expect(rendered).to match(/Error Message/)
    expect(rendered).to match(/Customer/)
    expect(rendered).to match(/4/)
  end
end
