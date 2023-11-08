class AddTokensToConversations < ActiveRecord::Migration[7.1]
  def change
    add_column :conversations, :token, :string, array: true, default: []
  end
end
