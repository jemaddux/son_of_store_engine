class NewUserConfirmation 
  @queue = :confirmation_email

  def self.perform 
    UserMailer.account_confirmation(email).deliver
  end
end 