class CreateBuzzwords < ActiveRecord::Migration
  def change
    create_table :buzzwords do |t|
      t.string :phrase

      t.timestamps
    end
    add_index :buzzwords, :phrase, :unique => true
  end
end
