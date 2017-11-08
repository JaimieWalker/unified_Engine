class Product < ApplicationRecord
	has_many :matches


	def self.save_products(product_array)
		attr_reader :current_products
		@@current_products = []
		product_array.each do |product|
			@@current_products << Product.find_or_create_by(name: product["id"], base_currency: product["base_currency"], quote_currency: product["quote_currency"], base_min_size: product["base_min_size"], base_max_size: product["base_max_size"], quote_increment: product["quote_increment"], display_name: product["display_name"], margin_enabled: product["margin_enabled"])
		end
		return @@current_products
	end
end
