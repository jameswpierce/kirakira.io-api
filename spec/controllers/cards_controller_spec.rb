require "rails_helper"

RSpec.describe CardsController, type: :controller do
  it { should be_an ApplicationController }
  describe "GET #index" do
    it "returns a success response" do
      card = create(:card)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      card = create(:card)
      get :show, params: { id: card.id }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Card" do
        card = build(:card)
        expect {
          post :create, params: { card: card.to_param }
        }.to change(Card, :count).by(1)
      end

      it "renders a JSON response with the new card" do
        card = build(:card)
        post :create, params: { card: card }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.location).to eq(card_url(Card.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new card" do
        post :create, params: { card: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested card" do
        card = create(:card)
        put :update, params: { id: card.to_param, card: new_attributes }
        card.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the card" do
        card = create(:card)

        put :update, params: { id: card.to_param, card: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the card" do
        card = create(:card)

        put :update, params: { id: card.to_param, card: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested card" do
      card = create(:card)
      expect {
        delete :destroy, params: { id: card.to_param }
      }.to change(Card, :count).by(-1)
    end
  end
end
