class CoinbaseChannel < ApplicationCable::Channel
  def subscribed
    stream_from "coinbase_matches"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
