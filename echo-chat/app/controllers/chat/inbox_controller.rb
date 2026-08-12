module Chat
  class InboxController < ApplicationController
    before_action :authenticate_user!

    def show
      org = current_organization
      unless org
        redirect_to organizations.organizations_path, alert: "Pick a workspace first." and return
      end
      ensure_demo!(org)
      @conversations = ChatConversation.for_organization(org).recent.limit(50)
      @open_count = ChatConversation.for_organization(org).open_status.count
      @replies = ChatCannedReply.for_organization(org).order(:title)
    end

    private

    def ensure_demo!(org)
      if ChatCannedReply.for_organization(org).none?
        ChatCannedReply.create!(organization: org, title: "Reset password", body: "You can reset your password from Settings → Security. Link expires in 2 hours.", trigger_keywords: "password, reset, login")
        ChatCannedReply.create!(organization: org, title: "Refund policy", body: "Refunds are available within 14 days for unused licenses. Share your order id and we will help.", trigger_keywords: "refund, money back, cancel")
        ChatCannedReply.create!(organization: org, title: "Shipping", body: "Digital products deliver instantly by email. Physical merch ships in 3-5 business days.", trigger_keywords: "shipping, delivery, track")
      end
      return if ChatConversation.for_organization(org).exists?
      c = ChatConversation.create!(organization: org, visitor_name: "Alex Rivera", visitor_email: "alex@example.com", subject: "Cannot reset password", status: "open", last_message_at: Time.current)
      c.chat_messages.create!(sender_type: "visitor", body: "Hi, I need to reset my password but the email never arrives.")
      c.chat_messages.create!(sender_type: "bot", body: ChatBotResponder.reply_for(org, "reset password"), from_bot: true)
    end
  end
end
