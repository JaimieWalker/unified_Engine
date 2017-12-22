class ProductController < ApplicationController
    def get_products
        # Should a price be added to the product table? Or should we also grab the most recent price match?
        render json: Product.all
    end
end
