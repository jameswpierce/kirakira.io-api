json.extract! review, :id, :user_id, :card_id, :next_review_at, :level, :is_locked, :created_at, :updated_at
json.url review_url(review, format: :json)
