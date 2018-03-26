class CreateCoinbaseMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :coinbase_matches do |t|

      t.timestamps
    end
  end
end
