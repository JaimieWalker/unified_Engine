require "faye/websocket"
require "eventmachine"

require 'json'
require 'net/https'

module MarketApiConnection
 	attr_accessor :products

	def self.start_api_connection
		products = get_products
		# creates a subscribe event for the market feed on gdax.com
		# create_individual_product_tables
		json = create_subscription
		run_event_loop_for_gdax(json)
	end
# Should probably be a rake task
	# def self.create_individual_product_tables
	# 	product_ids = Product.pluck(:name)
	# 	product_ids.each do |product|
	# 	end
	# end
# Makes url request to an external api
	def self.get_products
		uri = URI("https://api.gdax.com/products")
		res = Net::HTTP.get(uri)		# an array of hashes of product is returned
		products = JSON.parse(res)
		Product.connection if !Product.connected?
		# Returns the products created from the database
		Product.save_products(products)
	end


	def self.create_subscription
		# Now that we have the products, these products need to have a table created for each of them
		product_ids =  Product.pluck(:name)
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
				EM.run {
					ws = Faye::WebSocket::Client.new('wss://ws-feed.gdax.com')
					ws.on :open do |event|
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