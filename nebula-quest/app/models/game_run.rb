class GameRun < ApplicationRecord
  belongs_to :user
  validates :score, :distance, :ore_collected, :duration_ms, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :ship_name, presence: true, length: { maximum: 40 }
  scope :top, -> { order(score: :desc, created_at: :asc) }
end
