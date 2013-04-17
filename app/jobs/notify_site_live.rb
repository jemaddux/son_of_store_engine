class NotifySiteLive
  @queue = :confirmation_email

  def self.perform(store_name, store_id)
    UserMailer.site_live(store_name, store_id).deliver
  end
end