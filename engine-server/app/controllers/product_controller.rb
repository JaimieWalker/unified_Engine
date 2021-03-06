class ProductController < ApplicationController
    def get_products
        # Should a price be added to the product table? Or should we also grab the most recent price match?
        render json: Product.all
    end

    def recent
        products = {}
		Product.all.each do |prod|
            gdax_match = prod.matches.last
            kraken_match = prod.kraken_matches.last
            coinbase_match = prod.coinbase_matches.last
            gemini_match = prod.gemini_matches.last
			
            product_name = prod.base_currency + '-' + prod.quote_currency
            # &: is the safe navigation operator. It returns nil if a NoMethodError nil would occur
			products[product_name] = {:gemini_price => gemini_match&.price,
			:gemini_time => gemini_match&.created_at,
			:gdax_price => gdax_match&.price,
			:gdax_time => gdax_match&.created_at, 
			:kraken_price => kraken_match&.price, 
			:kraken_time => kraken_match&.created_at,
			:coinbase_price => coinbase_match&.price,
			:coinbase_time => coinbase_match&.created_at}
        end
        render json: products
    end
end
