class CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]

  # GET /cards
  # GET /cards.json
  def index
    limit = if params[:limit].to_i > 0
      then params[:limit].to_i
      else 20
      end
    page = if params[:page].to_i > 0
      then params[:page].to_i
      else 1
      end
    if params[:deck_id]
      @cards = Card
        .where(deck_id: params[:deck_id])
        .limit(limit).offset(page - 1 * limit)
    else
      @cards = Card
        .all
        .limit(limit)
        .offset((page - 1) * limit)
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    if @card.save
      render :show, status: :created, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    if @card.update(card_params)
      render :show, status: :ok, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def card_params
    params.require(:card).permit(:deck_id, :question, :answer, :order, :lesson)
  end
end
