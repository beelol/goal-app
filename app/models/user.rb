class User < ActiveRecord::Base
  attr_reader :password

  validates :username, presence: {message: "Username can't be blank"}
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :password_digest, presence: {message: "Password can't be blank"}
  validates :session_token, presence: true

  after_initialize :ensure_session_token

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil if user.nil?

    return user if user.is_password?(password)
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token

    self.save

    self.session_token
  end
end
