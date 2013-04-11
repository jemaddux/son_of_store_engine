class UserMailer < ActionMailer::Base
  default from: "no-reply@oregonsale.com"

  def order_confirmation(user_email, order)

    @confirmation_code = order.confirmation
    @confirmation_hash = order.confirmation_hash

    mail to: user_email
  end
end
