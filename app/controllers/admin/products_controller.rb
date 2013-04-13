class Admin::ProductsController < Admin::AdminController

  def index

    @dashboard = Dashboard.new
    authorize! :manage, Product

    render :index
  end

  def show
    @product = Product.find_by_id(params[:id])               

    if @product.retired == true
      redirect_to home_show_path
    else
      render :show
    end
  end

  def retire
    product = Product.find(params[:id])
    authorize! :update, product
    product.retired = true
    product.save

    redirect_to admin_path
  end

  def unretire
    product = Product.find(params[:id])
    authorize! :update, product
    product.retired = false
    product.save

    redirect_to admin_path
  end

  def new
    @product = Product.new
    authorize! :create, @product

    @categories = Category.where(store_id: current_user.store_id)

    render :new
  end

  def edit
    @product = Product.find(params[:id])
    authorize! :update, @product

    @categories = Category.all
  end

  def create
    params[:store_id] = current_user.store_id
    @product = Product.new(params[:product])
    authorize! :create, @product

    if @product.save
      redirect_to admin_product_path(@product), notice: 'Product was successfully created.'
    else
      redirect_to admin_path, notice: 'Sorry, product was not created'
    end
  end

  def update
    @product = Product.find(params[:id])
    authorize! :update, @product

    params[:product][:retired] ||= []
    params[:product][:category_ids] ||= []
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to admin_product_path(@product), notice: 'Product was successfully updated.'
    else
      redirect_to admin_path, notice: 'Sorry, product was not updated'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize! :destroy, @product
    @product.delete

    redirect_to products_url
  end
end
