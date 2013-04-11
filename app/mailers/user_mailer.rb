class UserMailer < ActionMailer::Base
  default from: "no-reply@themarketcollective.herokuapp.com"

  def order_confirmation(user_email, order)

    @confirmation_code = order.confirmation
    @confirmation_hash = order.confirmation_hash
    mail to: user_email
  end

  def site_live(store)
    @store = store
    user = User.find(@store.user_id)
    mail to: user.email
  end

  def site_declined(store)
    @store = store
    user = User.find(@store.user_id)
    mail to: user.email
  end  

end
