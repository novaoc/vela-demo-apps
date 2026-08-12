class CreateChatTables < ActiveRecord::Migration[8.1]
  def change
    create_table :chat_canned_replies do |t|
      t.references :organization, null: false, foreign_key: { to_table: :organizations_organizations }
      t.string :title, null: false
      t.text :body, null: false
      t.string :trigger_keywords, null: false, default: ""
      t.timestamps
    end

    create_table :chat_conversations do |t|
      t.references :organization, null: false, foreign_key: { to_table: :organizations_organizations }
      t.references :assignee, foreign_key: { to_table: :users }
      t.string :visitor_name, null: false, default: "Visitor"
      t.string :visitor_email, null: false, default: ""
      t.string :status, null: false, default: "open"
      t.string :subject, null: false, default: "New conversation"
      t.datetime :last_message_at
      t.timestamps
    end
    add_index :chat_conversations, [:organization_id, :status]

    create_table :chat_messages do |t|
      t.references :chat_conversation, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.string :sender_type, null: false, default: "visitor"
      t.text :body, null: false
      t.boolean :from_bot, null: false, default: false
      t.timestamps
    end
  end
end
