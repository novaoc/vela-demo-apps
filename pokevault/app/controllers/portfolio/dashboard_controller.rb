module Portfolio
  class DashboardController < ApplicationController
    before_action :authenticate_user!, except: :show

    def show
      if user_signed_in?
        @holdings = current_user.portfolio_holdings.includes(:pokemon_card).order(updated_at: :desc)
        @market_value = @holdings.sum(&:market_value_cents)
        @cost = @holdings.sum(&:cost_basis_cents)
        @gain = @market_value - @cost
      else
        @holdings = PortfolioHolding.none
        @market_value = @cost = @gain = 0
      end
      @top_cards = PokemonCard.order(market_price_cents: :desc).limit(6)
    end
  end
end
