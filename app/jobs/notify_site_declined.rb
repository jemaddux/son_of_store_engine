class NotifySiteDeclined 
  @queue = :confirmation_email

  def self.perform
    UserMailer.site_declined(@store).deliver
  end
end   