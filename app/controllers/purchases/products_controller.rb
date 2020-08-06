module Purchases
    class ProductsController < ApplicationController
        before_action :set_product, only: [:show]

        def index
            # Use CanCanCan to scope Orders
            products = Product.all
            @products = products.where(stripe_plan_name: nil, paypal_plan_name: nil)

            respond_to do |format|
                format.html { render "products/index", locals: { transaction_type: :purchase } }
            end
        end

        def show
            respond_to do |format|
                format.js   { render "products/show" }
            end
        end

        private

        def set_product
            @product = Product.find(params[:id])
        end

    end
end
