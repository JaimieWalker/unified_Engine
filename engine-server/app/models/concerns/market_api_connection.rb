require 'websocket-client-simple'
require 'json'
require 'net/https'
# GDAX API Connection
module MarketApiConnection
 	attr_accessor :products

	def self.start_api_connection
		products = get_products
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

# Makes url request to the gdax external api
	def self.get_products
		uri = URI("https://api.gdax.com/products")
		uri2 = URI("https://api.gemini.com/v1/symbols")
		begin
			res = Net::HTTP.get(uri)		# an array of hashes of product is returned
			res2 = Net::HTTP.get(uri2)
		rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError => e
			sleep 2
			retry
		end	
		# Can add error handling for when the api of the website is down
		products = JSON.parse(res)
		products2 = JSON.parse(res2)
		Product.connection if !Product.connected?
		# Returns the products created from the database
		Product.save_products(products)
	end


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

end