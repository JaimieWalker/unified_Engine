class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :base_currency
      t.string :quote_currency
      t.float :base_min_size
      t.integer :base_max_size
      t.float :quote_increment
      t.string :display_name
      t.boolean :margin_enabled

      t.timestamps
    end
  end
end
