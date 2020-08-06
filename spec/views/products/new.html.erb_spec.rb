require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      name: "MyString",
      stripe_plan_name: "MyString",
      paypal_plan_name: "MyString"
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input[name=?]", "product[name]"

      assert_select "input[name=?]", "product[stripe_plan_name]"

      assert_select "input[name=?]", "product[paypal_plan_name]"
    end
  end
end
