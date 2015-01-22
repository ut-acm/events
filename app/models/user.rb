class User < ActiveRecord::Base
  include Authority::UserAbilities
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :omniauthable,
         :omniauth_providers => [:google_oauth2]

  # callbacks
  after_create :create_profile
  # after_create :send_welcome
  # associations
  has_one :profile

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      user = User.create(email: data["email"],
                         password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  private
  def create_profile
    self.profile = Profile.new
    save
  end

  def send_welcome
    UserMailer.welcome(self).deliver
    puts "welcome message send"
  end

end
