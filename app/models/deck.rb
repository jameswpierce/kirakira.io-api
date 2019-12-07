# == Schema Information
#
# Table name: decks 
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Deck < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :cards, dependent: :destroy

  validates :title, presence: "can't be blank"
end
