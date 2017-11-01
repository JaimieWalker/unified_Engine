require "faye/websocket"
require "eventmachine"
require "pry"
require "pry-nav"

module MarketApiConnection

	def self.run_event_loop_for_gdax
		EM.run {
			ws = Faye::WebSocket::Client.new('wss://ws-feed.gdax.com')
			binding.pry
			ws.on :open do |event|
				p[:open]
				ws.send('Hello, world!')
			end

			ws.on :message do |event|
				p[:message, event.data]
			end

			ws.on :close do |event|
				p[:close, event.code, event.reason]
				ws = nil
			end
		}	
	end
	
end