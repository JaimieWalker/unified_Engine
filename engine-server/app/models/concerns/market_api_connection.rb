require 'websocket-client-simple'
require 'json'
require 'net/https'

# GDAX API Connection
module MarketApiConnection
 	attr_accessor :products

	def self.start_api_connection
		uri = URI("https://api.gdax.com/products")
		uri2_gemini = URI("https://api.gemini.com/v1/symbols")
		products = get_products(uri)
		products = get_gemini_products(uri2_gemini)

		# creates a subscribe event for the market feed on gdax.com
		# create_individual_product_tables
		json = create_subscription
		run_event_loop_for_gdax(json)
	end
	# Was implementing just in case their products expand
# Should probably be a rake task
	# def self.create_individual_product_tables
	# 	product_ids = Product.pluck(:name)
	# 	product_ids.each do |product|
	# 	end
	# end

# Makes url request to the external api
	def self.get_products(uri)
		begin
			res = Net::HTTP.get(uri)		# an array of hashes of product is returned
		rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
			sleep 2
			retry
		end	
		# Can add error handling for when the api of the website is down
		products = JSON.parse(res)
		Product.connection if !Product.connected?
		# Returns the products created from the database
		Product.save_products(products)
	end

# subscription for gdax
	def self.create_subscription
		# Now that we have the products, these products need to have a table created for each of them
		product_ids =  Product.pluck(:product_name)
		subscription = {
			"type": "subscribe",
			"product_ids": product_ids,
				"channels": [
							        {
						"name": "ticker",
						"product_ids": product_ids
						},
					]
				}

				json = JSON.generate(subscription)
	end

	def self.run_event_loop_for_gdax(json)
		# This removes logging in the console
		ActiveRecord::Base.logger = nil
				ws = WebSocket::Client::Simple.connect ('wss://ws-feed.gdax.com') 

					ws.on :open do |event|
						ws.send(json)
					end

					ws.on :message do |event|
						json = JSON.parse(event.data)
						if json["type"] == "subscriptions" || json["trade_id"].nil?
						else
							Match.save_match(json)
						end
					end

					ws.on :error do |event|
						# Need to figure out what to do if the server loses power. A regular server restart completely fixes the issue, but what if the whole server does not need to be restarted. How would you figure out how to reconnect to the websocket, without restarting the server?
						p [:error, event.message, event.errno]
					end
					ws.on :close do |event|
						p [:close, event[:data].message]
						ws = nil
					end
	end

# This function just checks if the product is already in the database

	def self.get_gemini_products(uri)
		begin
			res = Net::HTTP.get(uri)		# an array of hashes of product is returned
		rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
			sleep 2
			retry
		end	
		# Can add error handling for when the api of the website is down
		products = JSON.parse(res)
		products.each do |product|
			temp = String.new(product)
			temp.insert(3,'-')
			crypto_product = Product.where("product_name ~* ?", temp)[0]
			crypto_product.update(gemini_display_name: product)
			# Check the database for a similar text match
		end
		binding.pry
	end

	def self.run_event_loop_for_gemini
		
	end
end