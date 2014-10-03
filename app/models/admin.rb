require 'bcrypt'

class Admin < ActiveRecord::Base
  include BCrypt

  validates :username, presence: true
  validates :password_hash, presence: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
