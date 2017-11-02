require "faye/websocket"
require "eventmachine"
require "pry"
require "pry-nav"
require 'json'

module MarketApiConnection
	def self.create_json
				json = {
		    "type": "subscribe",
		    "product_ids": [
		        "ETH-USD",
		        "ETH-EUR"
		    ],
		    "channels": [
		        {
		            "name": "ticker",
		            "product_ids": [
		                "ETH-BTC"
		            ]
		        },
		    ]
		}

		json = JSON.generate(json)
	end

	def self.run_event_loop_for_gdax(json)
		EM.run {
			ws = Faye::WebSocket::Client.new('wss://ws-feed.gdax.com')
			ws.on :open do |event|
				binding.pry
				p [:open]
				ws.send(json)
			end

			ws.on :message do |event|
				binding.pry
				p [:message, event.data]
			end

			ws.on :error do |event|
				binding.pry
				p [:error]
			end
			ws.on :close do |event|
				binding.pry
				p [:close, event.code, event.reason]
				ws = nil
			end
		}	
	end
	
end