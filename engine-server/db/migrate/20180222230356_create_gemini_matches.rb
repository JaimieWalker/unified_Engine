class CreateGeminiMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :gemini_matches do |t|
      t.integer :socket_sequence, limit: 8
      t.string :g_type
      t.string :eventId
      t.string :side
      t.decimal :price
      t.decimal :remaining
      t.decimal :delta
      t.string :reason
      t.string :event_type
      t.belongs_to :product, foreign_key: true, index: true
      t.string :timestamp
      t.timestamps
    end
  end
end
