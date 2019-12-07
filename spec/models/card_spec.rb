require 'rails_helper'

RSpec.describe Card, type: :model do
  context 'associations' do
    it { should belong_to(:deck) }
  end

  context 'validations' do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:answer) }
  end
end
