class NotifySiteDeclined 
  @queue = :confirmation_email

  def self.perform(store_name, store_id)
    UserMailer.site_declined(store_name, store_id).deliver
  end
end   