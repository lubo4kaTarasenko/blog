class Author < ApplicationRecord
  has_secure_password
  
  has_many :posts
  has_many :comments

  def full_name
    "#{first_name} #{last_name} "
  end
end
