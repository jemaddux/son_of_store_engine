class NotifySiteLive
  @queue = :confirmation_email

  def self.perform
    UserMailer.site_live(@store).deliver
  end
end