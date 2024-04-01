class LayersOnCardsController < ApplicationController
  before_action :set_layers_on_card, only: %i[show edit update destroy]

  # GET /layers_on_cards or /layers_on_cards.json
  def index
    @layers_on_cards = LayersOnCard.all
  end

  # GET /layers_on_cards/1 or /layers_on_cards/1.json
  def show; end

  # GET /layers_on_cards/new
  def new
    @layers_on_card = LayersOnCard.new
  end

  # GET /layers_on_cards/1/edit
  def edit; end

  # POST /layers_on_cards or /layers_on_cards.json
  def create
    @layers_on_card = LayersOnCard.new(layers_on_card_params)

    respond_to do |format|
      if @layers_on_card.save
        format.html do
          redirect_to layers_on_card_url(@layers_on_card), notice: 'Layers on card was successfully created.'
        end
        format.json { render :show, status: :created, location: @layers_on_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @layers_on_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /layers_on_cards/1 or /layers_on_cards/1.json
  def update
    respond_to do |format|
      if @layers_on_card.update(layers_on_card_params)
        format.html do
          redirect_to layers_on_card_url(@layers_on_card), notice: 'Layers on card was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @layers_on_card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @layers_on_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /layers_on_cards/1 or /layers_on_cards/1.json
  def destroy
    @layers_on_card.destroy

    respond_to do |format|
      format.html { redirect_to layers_on_cards_url, notice: 'Layers on card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_layers_on_card
    @layers_on_card = LayersOnCard.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def layers_on_card_params
    params.require(:layers_on_card).permit(:name, :card_id, :layer_id, :layer_type, :status, :order, :user_id)
  end
end
