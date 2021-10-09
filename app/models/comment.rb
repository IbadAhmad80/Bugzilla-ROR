class Comment < ApplicationRecord
  belongs_to :bug
  validates :bug_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { minimum: 30 }
  default_scope -> { order(created_at: :desc) }
end
