class ProductChannel < ApplicationCable::Channel
  # Gdax matches
  def subscribed
    stream_from "product_info"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update_price
  end
end
