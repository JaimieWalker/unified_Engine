class CreateCoinbaseMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :coinbase_matches do |t|
      t.decimal :price
      t.belongs_to :product, foreign_key: true, index: true
      t.timestamps
    end
  end
end
