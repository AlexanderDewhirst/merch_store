class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  # def show
  # end

  # GET /orders/new
  # def new
  #   @order = Order.new
  # end

  # GET /orders/1/edit
  # def edit
  # end

  # POST /orders
  # POST /orders.json
  # def create
  #   @order = Order.new(order_params)

  #   respond_to do |format|
  #     if @order.save
  #       format.html { redirect_to @order, notice: 'Order was successfully created.' }
  #       format.json { render :show, status: :created, location: @order }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @order.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  # def update
  #   respond_to do |format|
  #     if @order.update(order_params)
  #       format.html { redirect_to @order, notice: 'Order was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @order }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @order.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /orders/1
  def destroy
    if @order.unpaid?
      @order.canceled!
      notification = { notice: 'Order was successfully canceled.' }
    else
      notification = { alert: "Order cannot be canceled." }
    end
    respond_to do |format|
      format.html { redirect_to purchases_orders_path, notification }
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def prepare_new_order
      @order = Order.new(order_params)
      @order.user_id = current_user.id
      @product = Product.find(@order.product_id)
      @order.price_cents = @product.price_cents
  end

  def order_params
      params.require(:orders).permit(:product_id, :token, :payment_gateway, :charge_id)
  end
end
