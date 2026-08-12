module Game
  class LeaderboardsController < ApplicationController
    def show
      @runs = GameRun.includes(:user).top.limit(25)
    end
  end
end
