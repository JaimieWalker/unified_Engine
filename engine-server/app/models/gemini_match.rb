class GeminiMatch < ApplicationRecord
    belongs_to :product
    after_create_commit :broadcast_product
    def broadcast_product
		ActionCable.server.broadcast("product_info",self.to_json)
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
