class Post < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
  has_rich_text :content

  validates :name, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :title, length: { maximum: 20, message: 'is too long' }

  before_save do
    self.text = content.body.to_plain_text if content
  end

  def self.search(pattern)
    if pattern.blank?
      all
    else
      where('title ILIKE ? or text ILIKE ?', "%#{pattern}%", "%#{pattern}%")
    end
  end
end
