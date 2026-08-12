class ChatBotResponder
  def self.reply_for(organization, text)
    canned = ChatCannedReply.for_organization(organization).find { |r| r.matches?(text) }
    return canned.body if canned

    lowered = text.to_s.downcase
    return "Thanks for reaching out! A teammate will join shortly. Meanwhile, try our help center or share your order id." if lowered.match?(/help|support|human|agent/)
    return "I can help with billing, shipping, and account access. What do you need?" if lowered.match?(/bill|invoice|pay|ship|account|login|password/)
    return "Got it. I've logged that for the team. Anything else I can answer?" if text.to_s.strip.length > 0

    "Hi! I'm Echo. Ask about billing, shipping, or type 'human' to reach an agent."
  end
end
