class Admin::ProductsController < Admin::AdminController

  def index
    begin
      authorize! :manage, Product
    rescue
      redirect_to store_home_path(params[:store_id])
      return
    end
    @dashboard = Dashboard.new(current_user.store_id)
    @user = current_user

    render :index, :notice => current_user.inspect
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

    redirect_to admin_products_path,
        notice: "The product '#{product.name}' was retired."
  end

  def unretire
    product = Product.find(params[:id])
    authorize! :update, product
    product.retired = false
    product.save

    redirect_to admin_products_path,
        notice: "The product '#{product.name}' was unretired."
  end

  def new
    @product = Product.new
    authorize! :create, @product

    @categories = Category.where(store_id: find_store_id)

    render :new
  end

  def edit
    @product = Product.find(params[:id])
    authorize! :update, @product

    @categories = Category.where(store_id: find_store_id)
  end

  def create
    params[:store_id] = find_store_id
    @product = Product.new(params[:product])
    authorize! :create, @product

    if @product.save
      redirect_to admin_products_path,
        notice: "The product '#{@product.name}' was successfully created."
    else
      redirect_to admin_products_path, notice: "The product was not created."
    end
  end

  def update
    @product = Product.find(params[:id])
    authorize! :update, @product

    params[:product][:retired] ||= []
    params[:product][:category_ids] ||= []
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to admin_products_path(@product),
        notice: "The product '#{@product.name}' was successfully updated."
    else
      redirect_to admin_products_path, notice: "The product was not updated."
    end
  end

  def destroy
    @product = Product.find(params[:id])
    authorize! :destroy, @product
    @product.delete

    redirect_to admin_products_path
  end

  private

  def find_store_id
    store_id = 0
    if current_user.role == "platform_admin"
      store_id = Store.find_by_path(params[:store_id])
    elsif current_user.role == "stocker" || current_user.role == "admin"
      store_id = current_user.store_id
    end
    store_id
  end
end
