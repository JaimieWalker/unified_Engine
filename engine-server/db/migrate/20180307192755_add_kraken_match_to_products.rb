class AddKrakenMatchToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :kraken_name, :string
    add_index :products, :kraken_name
    add_column :products, :coinbase_name, :string
    add_index :products, :coinbase_name
  end
end
