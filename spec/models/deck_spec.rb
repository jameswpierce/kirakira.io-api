# == Schema Information
#
# Table name: decks
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Deck, type: :model do
  context 'associations' do
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:cards).dependent(:destroy) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
  end
end
