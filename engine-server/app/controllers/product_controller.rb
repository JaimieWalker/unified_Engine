class ProductController < ApplicationController
    def get_products
        render json: Product.all
    end
end
