require 'net/https'

class CoinBaseApi
    def spot_price(currency_pair)
        uri = URI("https://api.coinbase.com/v2/prices/#{currency_pair}/spot")
        binding.pry
        res = Net::HTTP.get_response(uri)
        json = JSON.parse(res.body)
        json["data"]["amount"]
    end
    
end