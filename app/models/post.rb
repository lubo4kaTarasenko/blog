class Post < ApplicationRecord
  belongs_to :author

  validates :name, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :title, length: { maximum: 20, message:  "is too long"}
end
