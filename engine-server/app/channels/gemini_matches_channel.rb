class GeminiMatchesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "gemini_matches"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
