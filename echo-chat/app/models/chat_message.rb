class ChatMessage < ApplicationRecord
  belongs_to :chat_conversation
  belongs_to :user, optional: true
  validates :body, presence: true
  validates :sender_type, inclusion: { in: %w[visitor agent bot] }
  after_create_commit :touch_conversation

  private
  def touch_conversation
    chat_conversation.update!(last_message_at: created_at)
  end
end
