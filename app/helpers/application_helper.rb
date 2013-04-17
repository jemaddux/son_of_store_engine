module ApplicationHelper

  def find_session    
    @session ||= Session.find(session[:user_session_id]) 
  end

  # def find_session_cart
  #   cart ||= find_session.carts.find_by_store_id(@store.id)
  # end

  def cart_cost
    if session[:user_session_id]
      if find_session  && Session.find(session[:user_session_id]).carts.find_by_store_id(@store.id)
        cart = Session.find(session[:user_session_id]).carts.find_by_store_id(@store.id)
        subtotals = cart.line_items.map do |item|
          item.total
        end
        amount_in_dollars(add_all(subtotals))
      else
        0
      end
    end
  end

  def find_store_id_helper
    store_id = 0
    if current_user.role == "platform_admin"
      store_id = Store.find_by_path(params[:store_id]).id
    elsif current_user.role == "stocker" || current_user.role == "admin"
      store_id = current_user.store_id
    end
    store_id
  end

  def amount_in_dollars(cents)
    number_to_currency(cents.to_f / 100)
  end

  def add_all(items=[])
    items.inject(0, :+)
  end

  def us_states
   [['AK', 'AK'],['AL', 'AL'],['AR', 'AR'],['AZ', 'AZ'],['CA', 'CA'],
    ['CO', 'CO'],['CT', 'CT'],['DC', 'DC'],['DE', 'DE'],['FL', 'FL'],
    ['GA', 'GA'],['HI', 'HI'],['IA', 'IA'],['ID', 'ID'],['IL', 'IL'],
    ['IN', 'IN'],['KS', 'KS'],['KY', 'KY'],['LA', 'LA'],['MA', 'MA'],
    ['MD', 'MD'],['ME', 'ME'],['MI', 'MI'],['MN', 'MN'],['MO', 'MO'],
    ['MS', 'MS'],['MT', 'MT'],['NC', 'NC'],['ND', 'ND'],['NE', 'NE'],
    ['NH', 'NH'],['NJ', 'NJ'],['NM', 'NM'],['NV', 'NV'],['NY', 'NY'],
    ['OH', 'OH'],['OK', 'OK'],['OR', 'OR'],['PA', 'PA'],['RI', 'RI'],
    ['SC', 'SC'],['SD', 'SD'],['TN', 'TN'],['TX', 'TX'],['UT', 'UT'],
    ['VA', 'VA'],['VT', 'VT'],['WA', 'WA'],['WI', 'WI'],['WV', 'WV'],
    ['WY', 'WY']]
  end
end
