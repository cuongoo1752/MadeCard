class CardsController < ApplicationController
  include ApplicationHelper
  before_action :set_card, only: %i[show edit update destroy]

  # GET /cards or /cards.json
  def index
    @cards = Card.all
  end

  def design
    @layers_on_cards = []
    return unless params[:wish_id].present?

    wish = Wish.where(id: params[:wish_id]).first
    @title = Category.find_by(id: wish.category_id)&.content
    @content = wish&.content
  end

  # GET /cards/1 or /cards/1.json
  def show; end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit; end

  def create_card_and_layers
    msg_errors = []
    # Tạo card
    params_create_card = {
      is_public: true,
      user_id: get_user_id_request,
      order: get_max_order(Card)
    }.merge(create_params)
    @card = Card.create! params_create_card

    # Tạo layer
    ## Kiểm tra xem có layer không
    msg_errors << 'Thiết kế bị trống, vui lòng thử lại!' if params[:index].to_i == 0

    ## Lấy ra thông tin layer
    params.each do |key, value|
      next if value.blank?

      list_key = key.split('@')
      next unless list_key.size == 3 && list_key.first == 'layer'

      layer_type = list_key[1]
      layer_index = list_key[2]
      params_layer_on_card = {
        name: '',
        card_id: @card.id,
        user_id: get_user_id_request,
        order: get_max_order(LayersOnCard)
      }.merge(create_params)

      # Thêm loại vào layer
      case layer_type
      when 'text', 'textLong'
        is_long = layer_type == 'textLong'
        params_text = {
          is_long:,
          content: value
        }.merge(create_params)
        %w[font color size text_align vertical text_type width height top
           left].each do |attribute|
          params_text[:"#{attribute}"] = params[:"detailLayer@#{attribute}@#{layer_index}"]
        end
        params_layer_on_card[:layer] = Text.create!(params_text)
      end

      # Tạo layer
      LayersOnCard.create! params_layer_on_card
    end

    respond_to do |format|
      if @card
        format.html { redirect_to card_url(@card), notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to card_url(@card), notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.require(:card).permit(:is_public, :status, :user_id, :order)
  end
end
