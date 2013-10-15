require 'bcrypt'
class User < ActiveRecord::Base
  attr_reader :secret
  attr_accessible :email, :secret, :session_token, :activated, :activation_token
  validates :email,
      :password_digest,
      :session_token,
      :activation_token,
      presence: true

  validates :secret, length: { minimum: 6, allow_nil: true }
  validates :email, uniqueness: true
  before_validation :set_session_token
  before_validation :set_activation_token

  has_many(
  :notes,
  :class_name => "Note",
  :primary_key => :id,
  :foreign_key => :user_id
  )

  def secret=(secret)
    @secret = secret
    self.password_digest = BCrypt::Password.create(secret)
  end

  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

  def self.find_by_credentials(email, secret)
    user = User.find_by_email(email)
    return nil if user.nil?

    user.is_password?(secret) ? user : nil
  end

  def reset_session_token!
    self.session_token = User.generate_token
    self.save!
  end

  def set_session_token
    self.session_token ||= User.generate_token
  end

  def set_activation_token
    self.activation_token ||= User.generate_token
  end

  private

  def self.generate_token
    SecureRandom.urlsafe_base64(16)
  end

end
