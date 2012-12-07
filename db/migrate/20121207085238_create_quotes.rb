class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :character_id
      t.text :quote
      t.boolean :cussin

      t.timestamps
    end
  end
end
