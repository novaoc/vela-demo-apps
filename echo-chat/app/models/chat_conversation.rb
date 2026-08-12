class ChatConversation < ApplicationRecord
  belongs_to :organization, class_name: "Organizations::Organization"
  belongs_to :assignee, class_name: "User", optional: true
  has_many :chat_messages, dependent: :destroy
  validates :visitor_name, :subject, :status, presence: true
  validates :status, inclusion: { in: %w[open pending closed] }
  scope :for_organization, ->(org) { where(organization_id: org.id) }
  scope :open_status, -> { where(status: %w[open pending]) }
  def tokenish
    id.to_s
  end

  scope :recent, -> { order(Arel.sql("COALESCE(last_message_at, created_at) DESC")) }
end
