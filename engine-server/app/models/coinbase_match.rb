class CoinbaseMatch < ApplicationRecord

    belongs_to :product
    after_create_commit :broadcast_coinbase

    def broadcast_coinbase
        # ActionCable.server.config.logger = Logger.new(nil)
        c_match = self.attributes
        c_match["product_name"] = self.product.product_name
		ActionCable.server.broadcast("coinbase_matches",c_match.to_json)
    end

    def self.save_match(name,price)
        product = Product.find_by(product_name: name)
        c_match = CoinbaseMatch.create(price: price, product_id: product.id)
        product.coinbase_matches << c_match
    end
end
