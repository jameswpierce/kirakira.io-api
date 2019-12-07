FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Charles Barkley - #{n}" }
    sequence(:email) { |n| "chaosdunk#{n}@hotmail.com" }
    password { 'hoopzforever' }
  end

  factory :deck do
    title { 'Hiragana' }
  end

  factory :card do
    deck
    question { 'も' }
    answer { 'mo' }
  end

  factory :review do
    user
    card
    level { 0 }
    is_locked { false }
    next_review_at { DateTime.now - 1.second }
  end
end
