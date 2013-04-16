class NotifySiteLive
  @queue = :confirmation_email

  def self.perform(store)
    UserMailer.site_live(store).deliver
  end
end