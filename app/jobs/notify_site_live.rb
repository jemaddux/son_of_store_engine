class NotifySiteLive
  @queue = :confirmation_email

  def self.perform(store_path, store_id)
    UserMailer.site_live(store_path, store_id).deliver
  end
end