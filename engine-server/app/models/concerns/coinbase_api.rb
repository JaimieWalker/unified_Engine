require 'net/https'

class CoinBaseApi
    def spot_price(currency_pair)
        uri = URI("https://api.coinbase.com/v2/prices/#{currency_pair}/spot")
        binding.pry
        res = Net::HTTP.get_response(uri)
        json = JSON.parse(res.body)
        json["data"]["amount"]
    end
    
    def get_matches
        prod_arr = Product.where(coinbase: true)
        prod_arr.each do |product|
            spot_price(product.product_name)
            binding.pry

        end
    end

end