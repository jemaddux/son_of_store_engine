class SendConfirmationEmail
  @queue = :confirmation_email

  def self.perform 
    UserMailer.order_confirmation(order_user.email, confirmation_code, confirmation_hash)
  end
end