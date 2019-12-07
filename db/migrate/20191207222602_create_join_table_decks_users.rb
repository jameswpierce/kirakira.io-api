class CreateJoinTableDecksUsers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :decks, :users do |t|
      # t.index [:deck_id, :user_id]
      # t.index [:user_id, :deck_id]
    end
  end
end
