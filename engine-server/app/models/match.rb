class Match < ApplicationRecord
	belongs_to :product
# need to fix broadcast
	after_create_commit :broadcast_product
	def broadcast_product
		# ActionCable.server.config.logger = Logger.new(nil)
		ActionCable.server.broadcast("product_info",self.to_json)
	end

	def self.save_match(json)
		product = Product.find_by(product_name: json["product_id"])
		  # Assigning this for debug purposes. Lowers efficiency by a very insignificant amount for now 11/9/2017
		  a_match = Match.create(product_id: product.id) do |m|
			m.response_type = json["type"]
			m.product_name = json["product_id"]
			m.price = json["price"]
			m.open_24h = json["open_24h"]
			m.volume_24h = json["volume_24h"]
			m.low_24h = json["low_24h"]
			m.high_24h = json["high_24h"]
			m.volume_30d = json["volume_30d"]
			m.best_bid = json["best_bid"]
			m.best_ask = json["best_ask"]
			m.side = json["side"]
			m.time = json["time"]
			m.trade_id = json["trade_id"]
			m.last_size = json["last_size"]
			m.sequence = json["sequence"]
			m.exchange_name = "gdax"
		end
		product.matches << a_match
	end
end
