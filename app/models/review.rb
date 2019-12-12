# == Schema Information
#
# Table name: reviews
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  card_id        :integer
#  next_review_at :datetime
#  level          :integer
#  is_locked      :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Review < ApplicationRecord
  MAX_LEVEL = 12
  MIN_LEVEL = 0
  INTERVAL_FACTOR = 4

  belongs_to :user
  belongs_to :card
  belongs_to :deck

  validates :level, numericality: {
    only_integer: true,
    less_than_or_equal_to: MAX_LEVEL,
    greater_than_or_equal_to: MIN_LEVEL
  }

  def reviewable
    !is_locked && Time.now > next_review_at
  end

  def update_review_time
    self.next_review_at = (level**INTERVAL_FACTOR).minutes.from_now
  end

  def level_up
    level < MAX_LEVEL ? self.level += 1 : nil
  end

  def level_down
    level > MIN_LEVEL ? self.level -= 1 : nil
  end

  def check_answer(submitted_answer)
    correct = submitted_answer == card.answer
    correct ? level_up : level_down
    update_review_time
    correct
  end
end
