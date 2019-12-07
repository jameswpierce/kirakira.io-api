class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.datetime :next_review_at
      t.integer :level
      t.boolean :is_locked

      t.timestamps
    end
  end
end
