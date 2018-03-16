class Product < ApplicationRecord
	has_many :matches
	has_many :gemini_matches
	has_many :kraken_matches
	validates_uniqueness_of   :product_name
	def self.save_products(product_array)
		current_products = []
		product_array.each do |product|
			current_products << Product.find_or_create_by(product_name: product["id"]) do |p|
				p.base_currency = product["base_currency"]
				p.quote_currency = product["quote_currency"]
				p.base_min_size = product["base_min_size"]
				p.base_max_size = product["base_max_size"]
				p.quote_increment = product["quote_increment"]
				p.display_name = product["display_name"]
				p.margin_enabled = product["margin_enabled"]
				p.status = product["status"]
				p.status_message = product["status_message"]
				p.gdax = true
			end
		end
		return current_products
	end
end
