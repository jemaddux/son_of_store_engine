class LineItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    if current_cart = current_session.carts.find_by_store_id(product.store_id)
      @cart = current_cart
    else
      @cart = Cart.create(session_id: current_session.id,
                          store_id: product.store_id)
    end
    @line_item = @cart.add_product(product)
    @line_item.quantity = params[:quantity] if params[:quantity]
    redirect_after_create
  end

  def destroy
    @line_item = LineItem.find_by_id(params[:id])
    cart = Cart.find_by_id(@line_item.cart_id)
    store = Store.find_by_id(cart.store_id)
    @line_item.destroy
    redirect_to store_show_path(store.path)
  end

  def increase
    @line_item = LineItem.find(params[:id])
    if @line_item
      @line_item.update_attribute("quantity", @line_item.increase_quantity)
      cart = Cart.find_by_id(@line_item.cart_id)
      store = Store.find_by_id(cart.store_id)
      redirect_to store_show_path(store.path), notice: 'Product quantity has been updated.'
    end
  end

  def decrease
    @line_item = LineItem.find(params[:id])
    if @line_item
      cart = Cart.find_by_id(@line_item.cart_id)
      store = Store.find_by_id(cart.store_id)
      if @line_item.quantity <= 1
        @line_item.delete
        redirect_to store_show_path(store.path),
                    notice: 'Product quantity has been updated.'
      else
        @line_item.update_attribute("quantity", @line_item.decrease_quantity)
        redirect_to store_show_path(store.path),
                    notice: 'Product quantity has been updated.'
      end
    end
  end

  private

  def redirect_after_create
    if @line_item.save
      redirect_to :back, notice: 'Product successfully added to your cart.'
    else
      render action: "new"
    end
  end
end
