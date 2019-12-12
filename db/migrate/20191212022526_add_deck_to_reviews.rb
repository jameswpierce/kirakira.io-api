class AddDeckToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :deck, null: false, foreign_key: true, default: 1
  end
end
