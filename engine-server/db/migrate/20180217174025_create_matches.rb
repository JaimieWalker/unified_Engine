class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :response_type
      t.integer :sequence , limit: 8
      t.string :product_name, index: true
      t.decimal :price
      t.decimal :open_24h
      t.decimal :volume_24h
      t.decimal :low_24h
      t.decimal :high_24h
      t.decimal :volume_30d
      t.decimal :best_bid
      t.decimal :best_ask
      t.string :side
      t.datetime :time
      t.integer :trade_id , limit: 8
      t.decimal :last_size
      t.belongs_to :product, foreign_key: true, index: true
      t.string :exchange_name, index: true
      t.timestamps
    end
  end
end


