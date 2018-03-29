require 'kraken_ruby'

class KrakenApi

    API_KEY = Rails.application.secrets.kraken_api
    API_SECRET = Rails.application.secrets.kraken_secret
   
    def self.client
       @@client = Kraken::Client.new(API_KEY, API_SECRET)
    end
# You get a tuple when you get a pair from an asset pair
    def self.save_products
        pairs = client.asset_pairs
        pairs.each do |pair|
            if pair[0].size == 6
                temp = String.new(pair[0])
                temp.insert(3,'-')
                product = Product.find_by(product_name: temp)
                update_database(product,pair)
            else
                product = Product.find_by(product_name: pair[0])
                update_database(product,pair)
            end
        end
    end

    def self.update_database(product_in_db,pair_arr)
        product_object = pair_arr[1]
        if product_in_db.nil?
            product_in_db = Product.create(product_name: product_object["altname"]) do |p|
                p.base_currency = product_object["base"]
                 if product_object["quote"].size == 4 && product_object["quote"] != "DASH" && product_object["quote"] != "USDT"
                     product_object["quote"] = product_object["quote"].slice(1,3)
                 end   
                p.quote_currency = product_object["quote"]
                p.kraken_name = pair_arr[0]
                p.kraken = true
                
            end
        else
            product_in_db.update(kraken_name: pair_arr[0])
            product_in_db.update(kraken: true)
        end
    end

    def self.run_event_loop_for_kraken
        kraken_products = Product.pluck(:kraken_name).compact
        kraken_thread = Thread.new {
            kraken_products.each do |product|
                sleep 3
                ticker_info = client.ticker(product)
                KrakenMatch.save_match(ticker_info)
            end
        }
    end

end