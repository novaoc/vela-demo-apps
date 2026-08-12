module Game
  class PlaysController < ApplicationController
    before_action :authenticate_user!, only: :create

    def show
      if user_signed_in?
        @best = current_user.game_runs.maximum(:score).to_i
        @recent = current_user.game_runs.order(created_at: :desc).limit(5)
      else
        @best = 0
        @recent = GameRun.none
      end
    end

    def create
      run = current_user.game_runs.create!(run_params)
      render json: { id: run.id, score: run.score, rank: GameRun.where("score > ?", run.score).count + 1 }
    end

    private

    def run_params
      params.require(:run).permit(:score, :distance, :ore_collected, :duration_ms, :ship_name)
    end
  end
end
