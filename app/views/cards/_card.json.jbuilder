json.extract! card, :id, :deck_id, :question, :lesson, :answer, :order, :created_at, :updated_at
json.url card_url(card, format: :json)
