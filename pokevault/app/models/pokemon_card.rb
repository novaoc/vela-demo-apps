class PokemonCard < ApplicationRecord
  has_many :portfolio_holdings, dependent: :destroy
  validates :name, :set_name, :rarity, presence: true
  validates :market_price_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def market_price
    market_price_cents / 100.0
  end
end
