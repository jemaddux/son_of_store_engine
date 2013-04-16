class NotifySiteDeclined 
  @queue = :confirmation_email

  def self.perform(store)
    UserMailer.site_declined(store).deliver
  end
end   