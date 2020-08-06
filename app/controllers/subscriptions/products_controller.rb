module Subscriptions
    class ProductsController < ApplicationController
        before_action :set_product, only: [:show]

        def index
            products = Product.all
            @products = products.where.not(stripe_plan_name: nil, paypal_plan_name: nil)

            respond_to do |format|
                format.html { render "products/index", locals: { transaction_type: :subscription } }
            end
        end

        def show
            respond_to do |format|
                format.html { render "products/show", locals: { transaction_type: :subscription } }
            end
        end

        private

        def set_product
            @product = Product.find(params[:id])
        end

    end
end
