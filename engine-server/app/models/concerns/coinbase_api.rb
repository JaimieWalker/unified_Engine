require 'net/https'

class CoinBaseApi
    def spot_price(currency_pair)
        uri = URI("https://api.coinbase.com/v2/prices/#{currency_pair}/spot")
        res = Net::HTTP.get_response(uri)
        if res.message != "Not Found"
            json = JSON.parse(res.body)
            return json["data"]["amount"]
        end
    end
    
    def get_matches
        prod_arr = Product.where(coinbase: true)
        prod_arr.each do |product|
            price = spot_price(product.product_name)
            if !price.nil?
                CoinbaseMatch.save_match(product.product_name,price)
            end
        end
    end

    def self.run_event_loop_for_coinbase(coinbase_client)
        # Thread.new {
            coinbase_client.get_matches
        # }
    end
end