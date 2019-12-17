class AddLessonToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :lesson, :text, default: ''
  end
end
