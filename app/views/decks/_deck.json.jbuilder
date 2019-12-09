json.extract! deck, :id, :id, :title, :created_at, :updated_at
json.url deck_url(deck, format: :json)
json.cards_count deck.cards.count
