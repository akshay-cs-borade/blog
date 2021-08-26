class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  # Active Storage from Rails 5
  has_one_attached :thumbnail
  has_one_attached :banner
  # Action Text from Rails 6
  has_rich_text :body

  validates :title, length: { minimum: 5 }
  validates :body,  length: { minimum: 25 }

  self.per_page = 10
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  def optimized_image(image,x,y)
    image.variant(resize_to_fill: [x, y]).processed if image.present?
  end

  def slug_candidates
    [
      title,
      [title, id],
      "post-#{SecureRandom.hex(4)}"
    ]
  end
end
