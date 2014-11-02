class AddSentToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :sent, :boolean
  end
end
