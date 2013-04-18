class MakeUserNewAdmin
  @queue = :confirmation_email

  def self.perform(email, store_name)
    UserMailer.add_admin(email, store_name).deliver
  end
end
