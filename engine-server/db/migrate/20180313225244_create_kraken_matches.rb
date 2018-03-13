class CreateKrakenMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :kraken_matches do |t|
      t.decimal :volume_24h
      t.decimal :price
      t.belongs_to :product, foreign_key: true, index: true
      t.timestamps
    end
  end
end
