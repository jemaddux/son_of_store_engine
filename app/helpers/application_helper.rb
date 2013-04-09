module ApplicationHelper
  def cart_cost
    cart = current_cart
    subtotals = cart.line_items.map do |item|
      item.total
    end
    amount_in_dollars(add_all(subtotals))
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
