class KrakenMatchesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "kraken_matches"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
