class KrakenMatch < ApplicationRecord
    belongs_to :product
# https://www.kraken.com/help/api found at this url
    after_create_commit :broadcast_kraken
    def broadcast_kraken
        
    end

    def self.save_match(json)
        prod_name = json.keys[0]
        value = json[prod_name]
        kraken_match = KrakenMatch.create(last_trade_price: value["c"][0]) do |m|
           m.last_trade_volume = value["c"][1]
           m.ask_price = value["a"][0]
           m.ask_whole_volume = value["a"][1]
           m.ask_volume = value["a"][2]
           m.bid_price = value ["b"][0]
           m.bid_whole_volume = value["b"][1]
           m.bid_volume = value["b"][2]
           m.volume = value["v"][0]
           m.last_24h_volume = value["v"][1]
           m.weighted_price_avg = value["p"][0]
           m.weighted_price_avg_last_24h = value["p"][1]
           m.trades_today = value["t"][0]
           m.last_24h_trades = value["t"][1]
           m.todays_low = value["l"][0]
           m.low _24h= value["l"][1]
           m.todays_high = value["h"][0]
           m.high_24h = value["h"][1]
           m.open_price = value["o"]
        end
        binding.pry
    end
end
