class NewUserConfirmation 
  @queue = :confirmation_email

  def self.perform(email)
    UserMailer.account_confirmation(email).deliver
  end
end 