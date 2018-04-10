class GeminiMatch < ApplicationRecord
    belongs_to :product
    after_create_commit :broadcast_gemini
    def broadcast_gemini
        ActionCable.server.config.logger = Logger.new(nil)
        g_match = self.attributes
        g_match["product_name"] = self.product.base_currency + '-' + self.product.quote_currency
        g_match["api"] = "gemini"
		ActionCable.server.broadcast("gemini_matches",g_match.to_json)
    end
    
    def self.save_match(json,g_name)
        events = json["events"].first
        product = Product.find_by(gemini_display_name: g_name)
        gemini_match = GeminiMatch.create!(product_id: product.id) do |m|
            m.g_type = json["type"]
            m.eventId = json["eventId"]
            m.socket_sequence = json["socket_sequence"]
            m.timestamp = json["timestamp"]
            m.side = events["side"]
            m.price = events["price"]
            m.event_type = events["type"]
            m.remaining = events["remaining"]
            m.delta = events["delta"]
            m.reason = events["reason"]
        end
        product.gemini_matches << gemini_match
    end

end
