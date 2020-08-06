require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      name: "Name",
      stripe_plan_name: "Stripe Plan Name",
      paypal_plan_name: "Paypal Plan Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Stripe Plan Name/)
    expect(rendered).to match(/Paypal Plan Name/)
  end
end
