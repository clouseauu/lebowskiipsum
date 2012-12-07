class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :short_name
      t.boolean :is_main

      t.timestamps
    end
  end
end
