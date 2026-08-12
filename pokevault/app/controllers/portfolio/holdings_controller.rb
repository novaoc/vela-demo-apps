module Portfolio
  class HoldingsController < ApplicationController
    before_action :authenticate_user!

    def create
      card = PokemonCard.find(params[:pokemon_card_id])
      holding = current_user.portfolio_holdings.find_or_initialize_by(pokemon_card: card)
      holding.quantity = holding.quantity.to_i + params.fetch(:quantity, 1).to_i
      holding.cost_basis_cents += params.fetch(:cost_basis_cents, card.market_price_cents).to_i
      holding.condition = params[:condition].presence || holding.condition || "NM"
      holding.save!
      redirect_to root_path, notice: "Added #{card.name} to your vault."
    end

    def destroy
      holding = current_user.portfolio_holdings.find(params[:id])
      holding.destroy!
      redirect_to root_path, notice: "Removed holding."
    end
  end
end
