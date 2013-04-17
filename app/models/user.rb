class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :orders
  belongs_to :store

  attr_accessible :full_name, :display_name, :email, :password,
                  :password_confirmation, :role, :store_id

  validates_presence_of :full_name, on: :create
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email


  ROLES = %w[superuser admin user]

  def role?(role)
    self.role == role.to_s
  end

  def self.create_guest_user(email)
    user = new email: email
    user.full_name = "Jane Doe"
    user.password = "RANDOM_PASSWORD"
    user.account_type = "inactive"
    user.save
    user
  end

  def update_user_role(updated_role, store)
    if updated_role == "user"
      if Store.find_store_users(store).size > 1
        self.role = updated_role 
        self.save!
      end
    else
      self.role = updated_role 
      self.save!
    end
  end

  def update_user(params)
    self.full_name             = params[:full_name]
    self.email                 = params[:email]
    self.display_name          = params[:display_name]
    self.password              = params[:password]
    self.password_confirmation = params[:password_confirmation]
    self.role                  = 'user'
  end
end
