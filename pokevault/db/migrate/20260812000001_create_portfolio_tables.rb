class CreatePortfolioTables < ActiveRecord::Migration[8.1]
  def change
    create_table :pokemon_cards do |t|
      t.string :name, null: false
      t.string :set_name, null: false
      t.string :number, null: false, default: ""
      t.string :rarity, null: false, default: "Common"
      t.integer :market_price_cents, null: false, default: 0
      t.string :image_emoji, null: false, default: "🃏"
      t.timestamps
    end
    add_index :pokemon_cards, [:set_name, :number], unique: true

    create_table :portfolio_holdings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pokemon_card, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.integer :cost_basis_cents, null: false, default: 0
      t.string :condition, null: false, default: "NM"
      t.timestamps
    end
    add_index :portfolio_holdings, [:user_id, :pokemon_card_id], unique: true
  end
end
