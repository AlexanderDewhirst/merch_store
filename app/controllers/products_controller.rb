class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    raise ActionController::RoutingError.new('Not Found')
  end

  # GET /products/1
  # GET /products/1.json
  def show
    raise ActionController::RoutingError.new('Not Found')
  end

  # GET /products/new
  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  # GET /products/1/edit
  def edit
    @photo = @product.photo
  end

  # POST /products
  # POST /products.json
  def create
    handle_money
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        @product.photo.image_derivatives!
        @product.photo.save
        format.html { redirect_to purchases_products_path, notice: 'Product was successfully created.' }
      else
        @photo = @product.build_photo
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price, photo_attributes: [:id, :image])
    end

    def handle_money
      params[:product][:price] = params[:product][:price].to_f.round(2)
    end
end
