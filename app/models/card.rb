class Card < ApplicationRecord
  belongs_to :deck

  validates :question, presence: "can't be blank"
  validates :answer, presence: "can't be blank"
end
