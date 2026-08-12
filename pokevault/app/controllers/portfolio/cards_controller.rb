module Portfolio
  class CardsController < ApplicationController
    def index
      @cards = PokemonCard.order(:set_name, :name)
      @q = params[:q].to_s.strip
      @cards = @cards.where("name ILIKE ? OR set_name ILIKE ?", "%#{@q}%", "%#{@q}%") if @q.present?
    end

    def show
      @card = PokemonCard.find(params[:id])
    end
  end
end
