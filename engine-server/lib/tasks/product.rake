require 'json'
require 'net/https'

namespace :product do
  desc "Creates a migration for a list of products from the gdax website, if the gdax api adds more currencies, this task should create a new migration for it"
  task gdax_migration: :environment do
  		uri = URI("https://api.gdax.com/products")
		res = Net::HTTP.get(uri)		# an array of hashes of product is returned
		products = JSON.parse(res)
		products.first
		# sh allows you to run a shell command
		# sh "rails g migration Product name:string"
		Rake::Task["db:migrate"].invoke
  end

end
