class Author < ApplicationRecord
  has_many :posts
  has_many :comments  

  def full_name
    "#{self.first_name} #{self.last_name} "
  end
end
