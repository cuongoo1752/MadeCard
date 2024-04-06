class WishesController < ApplicationController
  before_action :set_wish, only: %i[show edit update destroy]

  # GET /wishes or /wishes.json
  def index
    load_wishes
  end

  def update_all
    msg_errors = []

    ActiveRecord::Base.transaction do
      params.each do |key, value|
        next if value.blank?

        list_key = key.split('@')

        next if list_key.size != 2 || list_key.first != 'type'

        wish_id = list_key[1]
        case value
        when 'update'
          wish = Wish.find_by(id: wish_id)
          if wish_id.blank? || wish.blank?
            msg_errors << 'Lời chúc này đã không còn tồn tại!'
            next
          end

          if params[:"content@#{wish_id}"] == wish.content && params[:"status@#{wish_id}"].to_i == wish.status.to_i
            next
          end

          wish.update!(
            category_id: params[:category_id],
            content: params[:"content@#{wish_id}"].strip,
            status: params[:"status@#{wish_id}"].to_i,
            updated_at: Time.zone.now,
            user_id: current_user.id
          )
        when 'create'
          wish = Wish.find_by(id: wish_id)
          if wish_id.blank? || wish.present?
            msg_errors << 'Có lỗi xảy ra!'
            next
          end

          next if params[:"content@#{wish_id}"].blank?

          Wish.create!(
            category_id: params[:category_id],
            content: params[:"content@#{wish_id}"].strip,
            status: params[:"status@#{wish_id}"].to_i,
            created_at: Time.zone.now,
            user_id: current_user.id
          )
        end
      end
    end
    load_wishes

    redirect_to wishes_url(category_id: params[:category_id]), notice: 'Cập nhật lời chúc thành công!'
  rescue StandardError => e
    load_wishes
    flash.alert = e.message + msg_errors.join('<br>')
    render :index
  end

  private

  def load_wishes
    @category = Category.find_by(id: params[:category_id])
    @max_id = Wish.maximum(:id).to_i

    if params[:category_id].blank? || @category.blank?
      @wishes = []
      flash.alert = 'Url không hợp lệ!'
      return render(:index)
    end

    @wishes = Wish.where(category_id: params[:category_id], status: 1).order(created_at: :asc)
  end
end
