class SendNewAdminEmail

  @queue = :confirmation_email

  def self.perform(email, store_name, temp_password)
    UserMailer.new_admin(email, store_name, temp_password).deliver
  end
end
