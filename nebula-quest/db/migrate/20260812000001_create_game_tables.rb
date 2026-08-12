class CreateGameTables < ActiveRecord::Migration[8.1]
  def change
    create_table :game_runs do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :score, null: false, default: 0
      t.integer :distance, null: false, default: 0
      t.integer :ore_collected, null: false, default: 0
      t.integer :duration_ms, null: false, default: 0
      t.string :ship_name, null: false, default: "Scout"
      t.timestamps
    end
    add_index :game_runs, [:score, :created_at]
  end
end
