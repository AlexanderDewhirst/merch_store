module Purchases
    class OrdersController < ::OrdersController
        before_action :authenticate_user!

        def index
            # Use CanCanCan to authorize routes and scope Orders
            # Use model scopes for queries
            if current_user.contributor?
                @orders = Order.where.not(status: [:unpaid, :canceled])
            else
                @orders = current_user.orders.where.not(status: [:unpaid, :canceled])
            end

            respond_to do |format|
                format.html { render "orders/index", locals: { order_type: :past } }
            end
        end

        def cart
            if current_user.contributor?
                @orders = Order.where(status: :unpaid)
            else
                @orders = current_user.orders.where(status: :unpaid)
            end

            respond_to do |format|
                format.html { render "orders/index", locals: { order_type: :cart } }
            end
        end

        def create
            prepare_new_order
            @order.unpaid!
            if @order.save
                redirect_to purchases_products_path, notice: "#{@order.product.name} successfully added to cart."
            else
                redirect_to purchases_products_path, alert: "Unsuccessfully added item to cart."
            end
        end

        def checkout
            ## NOTE: Potentially make one card payment for a Cart object (has_many)
            ## TODO: Make batch execution
            ## TODO: Pass params[:token] with javascript submit()
            @orders = current_user.orders.where(status: :unpaid)
            if order_params[:payment_gateway] == "stripe"
                @orders.each do |order|
                    Orders::Stripe.execute(order: order, user: current_user)
                    order.assign_attributes(
                        payment_gateway: order_params[:payment_gateway],
                        token: order_params[:token]
                    )
                end
            elsif order_params[:payment_gateway] == "paypal"
                # PayPal
            end
            ## TODO: Not sure why model validations on condition are failing with:
            # if @orders.map{ |order| order.save && order.paid! }

            if @orders.none?{ |order| order.token.nil? }
                @orders.map{ |order| order.save && order.paid! }
                redirect_to purchases_products_path, notice: "Payment successful."
            else
                redirect_to cart_purchases_orders_path, alert: "Payment unsuccessful."
            end
        rescue => e
            Rails.logger.error e
        end

        private

        def prepare_new_order
            @order = Order.new
            @order.user_id = current_user.id
            @product = Product.find(params[:product_id])
            @order.product = @product
            @order.price_cents = @product.price_cents
        end

        def order_params
            params.require(:order).permit(:product_id, :token, :charge_id, :price_cents, :payment_gateway)
        end

    end
end
