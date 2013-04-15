class UserMailer < ActionMailer::Base
  default from: "no-reply@themarketcollective.herokuapp.com"

  def order_confirmation(user_email, order_code, order_hash)

    @confirmation_code = order_code
    @confirmation_hash = order_hash
    mail to: user_email
  end

  def account_confirmation(email)
    mail to: email
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

  def new_admin(email, store, temp_password)
    @store = store
    @email = email
    @temp_password = temp_password
    mail to: email
  end

  def add_admin(email, store)
    @store = store
    mail to: email
  end

end
