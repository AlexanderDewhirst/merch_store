require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        name: "Name",
        stripe_plan_name: "Stripe Plan Name",
        paypal_plan_name: "Paypal Plan Name"
      ),
      Product.create!(
        name: "Name",
        stripe_plan_name: "Stripe Plan Name",
        paypal_plan_name: "Paypal Plan Name"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Stripe Plan Name".to_s, count: 2
    assert_select "tr>td", text: "Paypal Plan Name".to_s, count: 2
  end
end
