class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reports
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def create_newtoke
    self.reset_token = User.new_token
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  def create_reset_digest
    self.reset_token = User.new_token
  end
# Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end
