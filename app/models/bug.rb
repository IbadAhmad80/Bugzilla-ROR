class Bug < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { minimum: 30 }
  validates :priority, presence: true
  validates :status, presence: true
  validates :estimated_time, presence: true
  default_scope -> { order(created_at: :desc) }
end
