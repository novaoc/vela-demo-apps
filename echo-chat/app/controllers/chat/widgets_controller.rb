module Chat
  class WidgetsController < ApplicationController
    def show
      @conversation = ChatConversation.find(params[:id])
      @messages = @conversation.chat_messages.order(:created_at)
    end

    def update
      @conversation = ChatConversation.find(params[:id])
      body = params.require(:body)
      @conversation.chat_messages.create!(sender_type: "visitor", body: body, from_bot: false)
      bot = ChatBotResponder.reply_for(@conversation.organization, body)
      @conversation.chat_messages.create!(sender_type: "bot", body: bot, from_bot: true)
      redirect_to chat_widget_path(@conversation)
    end
  end
end
