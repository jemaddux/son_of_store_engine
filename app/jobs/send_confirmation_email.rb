class SendConfirmationEmail
  @queue = :confirmation_email

  def self.perform(order_user_email, confirmation_code, confirmation_hash)
    UserMailer.order_confirmation(order_user_email, confirmation_code,
               confirmation_hash).deliver
  end
end
