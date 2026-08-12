class PortfolioHolding < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon_card
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :cost_basis_cents, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :condition, inclusion: { in: %w[NM LP MP HP DMG] }
  validates :pokemon_card_id, uniqueness: { scope: :user_id }

  def market_value_cents
    quantity * pokemon_card.market_price_cents
  end

  def gain_cents
    market_value_cents - cost_basis_cents
  end
end
