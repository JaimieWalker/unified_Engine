class CreateGeminiMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :gemini_matches do |t|

      t.timestamps
    end
  end
end
