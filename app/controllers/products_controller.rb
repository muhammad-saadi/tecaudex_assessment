class ProductsController < ApplicationController
  before_action :require_vendor, except: [:index, :show]

  def index
    @products = Product.all
  end

  def new
    @product = current_user.products.build
    @categories = Category.all
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      @product.categories << Category.where(id: params[:product][:category_ids])
      redirect_to @product, notice: 'Product created successfully.'
    else
      @categories = Category.all
      render :new
    end
  end

   def show
    @product = Product.find(params[:id])
  end

  def vendor_products
    @products = current_user.products
    @product = Product.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def add_to_cart
    @product = Product.find(params[:id])
    current_user.cart.products << @product
    redirect_to root_path, notice: 'Product added to cart successfully.'
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, category_ids: [])
  end

  def require_vendor
    redirect_to login_url, alert: 'Access denied.' unless current_user&.vendor?
  end
end
