# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  fullname        :string(255)
#  email           :string(255)
#  username        :string(255)
#  password        :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :password, :username, :password_confirmation, :fullname, :email
  
  has_many :bookmarks  
  has_secure_password
  

  before_save { |user| user.username = username.downcase }
  before_save :create_remember_token

  validates :username, presence: true, length: { maximum: 50 },
              uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 7, maximum: 40 }
  validates :password_confirmation, presence: true
  validates :fullname, length: { minimum: 2, maximum: 75}
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end
