class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :product_name, index: true
      t.string :base_currency
      t.string :quote_currency
      t.decimal :base_min_size
      t.integer :base_max_size , limit: 8
      t.decimal :quote_increment
      t.string :display_name
      t.string :status
      t.boolean :margin_enabled
      t.string :status_message
      t.string :gemini_display_name
      t.boolean :gdax
      t.boolean :gemini
      t.boolean :coinbase
      t.boolean :kraken
      t.timestamps
    end
  end
end