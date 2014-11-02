class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.text :body
      t.integer :source
      t.datetime :time

      t.timestamps
    end
  end
end
