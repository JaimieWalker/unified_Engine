require 'kraken_ruby'

class KrakenApi

    API_KEY = Rails.application.secrets.kraken_api
    API_SECRET = Rails.application.secrets.kraken_secret
   
    def self.client
       @@client = Kraken::Client.new(API_KEY, API_SECRET)
    end

end