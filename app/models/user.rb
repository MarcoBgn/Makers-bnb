require 'data_mapper'
require 'dm-validations'
require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, unique: true
  property :password_digest, Text
  property :name, String
  property :username, String, unique: true

  def password=(password)
    @password=password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    user && BCrypt::Password.new(user.password_digest) == password ? user : nil
  end

  attr_reader :password
  attr_accessor :password_confirmation

  has n, :spaces
  has n, :requests

  validates_confirmation_of :password

  validates_length_of :email, :min => 5
  validates_format_of :email, :as => :email_address

end
