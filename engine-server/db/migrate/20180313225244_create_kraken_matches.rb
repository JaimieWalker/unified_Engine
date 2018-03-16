class CreateKrakenMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :kraken_matches do |t|
      t.decimal :volume_24h
      t.decimal :price
      t.decimal :last_trade_volume 
      t.decimal :ask_price 
      t.decimal :ask_whole_volume 
      t.decimal :ask_volume 
      t.decimal :bid_price
      t.decimal :bid_whole_volume 
      t.decimal :bid_volume 
      t.decimal :volume 
      t.decimal :last_24h_volume 
      t.decimal :weighted_price_avg 
      t.decimal :weighted_price_avg_last_24h 
      t.integer :trades_today 
      t.integer :last_24h_trades 
      t.decimal :todays_low 
      t.decimal :low_24h 
      t.decimal :todays_high 
      t.decimal :high_24h 
      t.decimal :open_price  
      t.belongs_to :product, foreign_key: true, index: true
      t.timestamps
    end
  end
end
