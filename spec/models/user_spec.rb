require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    # it { should have_many(:reviews) }
    it { should have_and_belong_to_many(:decks) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end
end
