module Chat
  class CannedRepliesController < ApplicationController
    before_action :authenticate_user!

    def create
      ChatCannedReply.create!(
        organization: current_organization,
        title: params.require(:title),
        body: params.require(:body),
        trigger_keywords: params[:trigger_keywords].to_s
      )
      redirect_to chat_inbox_path, notice: "Canned reply saved."
    end

    def destroy
      ChatCannedReply.for_organization(current_organization).find(params[:id]).destroy!
      redirect_to chat_inbox_path, notice: "Removed."
    end
  end
end
