module Chat
  class ConversationsController < ApplicationController
    before_action :authenticate_user!, except: %i[create]
    before_action :set_org_conversation, only: %i[show update]

    def show
      @messages = @conversation.chat_messages.order(:created_at)
      @replies = ChatCannedReply.for_organization(current_organization).order(:title)
    end

    def create
      # Public widget intake
      org = Organizations::Organization.find(params.require(:organization_id))
      conversation = ChatConversation.create!(
        organization: org,
        visitor_name: params[:visitor_name].presence || "Visitor",
        visitor_email: params[:visitor_email].to_s,
        subject: params[:subject].presence || "Website chat",
        status: "open",
        last_message_at: Time.current
      )
      body = params.require(:body)
      conversation.chat_messages.create!(sender_type: "visitor", body: body, from_bot: false)
      bot = ChatBotResponder.reply_for(org, body)
      conversation.chat_messages.create!(sender_type: "bot", body: bot, from_bot: true)
      redirect_to chat_widget_path(conversation.tokenish), notice: "Chat started."
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: "Workspace not found."
    end

    def update
      if params[:message].present?
        @conversation.chat_messages.create!(sender_type: "agent", body: params[:message], user: current_user, from_bot: false)
      end
      @conversation.update!(status: params[:status]) if params[:status].present?
      @conversation.update!(assignee: current_user) if params[:claim] == "1"
      redirect_to chat_conversation_path(@conversation)
    end

    private

    def set_org_conversation
      @conversation = ChatConversation.for_organization(current_organization).find(params[:id])
    end
  end
end
