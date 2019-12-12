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

require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:card) }
    it { should belong_to(:deck) }
  end

  context 'validations' do
    it {
      should validate_numericality_of(:level)
        .only_integer
        .is_less_than_or_equal_to(Review::MAX_LEVEL)
        .is_greater_than_or_equal_to(Review::MIN_LEVEL)
    }
  end

  it 'is reviewable if time is after next_review_at' do
    review = create(:review)

    review.next_review_at = 1.day.from_now
    expect(review.reviewable).to be_falsy

    review.next_review_at = 1.day.ago
    expect(review.reviewable).to be_truthy
  end

  it 'is not reviewable if is_locked' do
    review = create(:review)

    review.is_locked = true
    review.next_review_at = 1.day.ago
    expect(review.reviewable).to be_falsy
  end

  describe 'it correctly updates review level' do
    it 'goes to next level if answer is correct' do
      review = create(:review)

      review.level = 0
      review.card.question = 'と'
      review.card.answer = 'to'

      review.check_answer('to')
      expect(review.level).to eq(1)
    end

    it 'goes to previous level if answer is incorrect' do
      review = create(:review)

      review.level = 1
      review.card.question = 'と'
      review.card.answer = 'to'

      review.check_answer('no')
      expect(review.level).to eq(0)
    end

    it 'does not go past max level or below min level' do
      review = create(:review)

      review.level = Review::MIN_LEVEL
      review.card.question = 'と'
      review.card.answer = 'to'

      review.check_answer('no')
      expect(review.level).to eq(0)

      review.level = Review::MAX_LEVEL

      review.check_answer('to')
      expect(review.level).to eq(12)
    end
  end
  it 'updates next review time based on level' do
    review = create(:review)

    review.level = Review::MIN_LEVEL
    review.card.question = 'と'
    review.card.answer = 'to'
    review.next_review_at = 1.minute.ago
    review.check_answer('to')
    interval = (review.level**Review::INTERVAL_FACTOR).minutes

    expect(review.next_review_at).to be_within(1.second).of(interval.from_now)
  end
end
