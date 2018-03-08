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
                
            end

        end
    end


end