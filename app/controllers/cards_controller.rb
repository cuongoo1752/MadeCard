class CardsController < ApplicationController
  include ApplicationHelper
  before_action :set_card, only: %i[show edit update destroy]

  def index
    @cards = if params[:role] == role_admin && is_current_admin?
               Card.order(created_at: :desc).page(params[:page])
             else
               Card.where(user_id: current_user.id, status: 1).order(created_at: :desc).page(params[:page])
             end
  end

  def design
    @layers_on_cards = []
    if params[:wish_id].present?
      # Vào từ màn lời chúc
      wish = Wish.where(id: params[:wish_id]).first
      @title = Category.find_by(id: wish.category_id)&.content
      @content = wish&.content
    elsif params[:fix_picture_id].present?
      # Vào từ màn ảnh
      @fix_picture = FixPicture.find_by(id: params[:fix_picture_id])
    elsif params[:card_id].present?
      # Vào từ màn danh sách thiệp
      @card = Card.find_by(id: params[:card_id], status: 1)
      if @card.present?
        @public_flg = 1 if params[:public].to_i == 1

        # Lấy ảnh nền
        @fix_picture = FixPicture.find_by(id: @card.fix_picture_id)

        # Lấy dữ liệu các layer
        @layers = []
        LayersOnCard.where(card_id: @card.id, status: 1).order(:order).each do |layer_on_card|
          @layers << {
            layer_type: layer_on_card.layer_type,
            layer_detail: layer_on_card.layer
          }
        end
      end
    end

    # Load các giá trị
    @fix_pictures = FixPicture.where(status: 1)
    @fix_fonts = FixFont.where(status: 1)
    return unless @fix_picture&.picture.to_s.blank?

    @fix_pictures.each do |fix_picture|
      if fix_picture&.picture.present?
        @fix_picture = fix_picture
        break
      end
    end
  end

  def show; end

  def new
    @card = Card.new
  end

  def edit; end

  def create_card_and_layers
    msg_errors = []
    # Tạo card
    params_create_card = {
      is_public: true,
      user_id: get_user_id_request,
      fix_picture_id: params[:fix_picture_id],
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
      when 'image', 'image-old'
        image_url = params[:"layer@image@#{layer_index}"]
        if params[:"layer@image@#{layer_index}"].blank?
          image_url = Image.find_by(id: params[:"layer@image-old@#{layer_index}"]).url
        end
        next if image_url.blank?

        params_text = {
          url: image_url
        }.merge(create_params)
        %w[width height top left].each do |attribute|
          params_text[:"#{attribute}"] = params[:"detailLayer@#{attribute}@#{layer_index}"]
        end
        params_layer_on_card[:layer] = Image.create!(params_text)
      end

      # Tạo layer
      LayersOnCard.create! params_layer_on_card
    end

    if @card
      redirect_to cards_url, notice: 'Đã tạo thiệp thành công'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to card_url(@card), notice: 'Tạo thiệp thành công!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @card.update(card_params)
      redirect_to card_url(@card), notice: 'Cập nhận thiệp thành công!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @card.update(delete_params)

    redirect_to cards_url, notice: 'Xóa thiệp thành công!'
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:is_public, :status, :user_id, :order)
  end
end
