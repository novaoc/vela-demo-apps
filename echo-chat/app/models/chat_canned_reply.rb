class ChatCannedReply < ApplicationRecord
  belongs_to :organization, class_name: "Organizations::Organization"
  validates :title, :body, presence: true
  scope :for_organization, ->(org) { where(organization_id: org.id) }

  def matches?(text)
    keywords = trigger_keywords.to_s.split(",").map { |k| k.strip.downcase }.reject(&:blank?)
    return false if keywords.empty?
    hay = text.to_s.downcase
    keywords.any? { |k| hay.include?(k) }
  end
end
