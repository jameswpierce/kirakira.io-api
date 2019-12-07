class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.references :deck, null: false, foreign_key: true
      t.text :question
      t.text :answer
      t.integer :order

      t.timestamps
    end
  end
end
