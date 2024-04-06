class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories or /categories.json
  def index
    load_categories
  end

  def update_all
    msg_errors = []

    ActiveRecord::Base.transaction do
      params.each do |key, value|
        next if value.blank?

        list_key = key.split('@')

        next if list_key.size != 2 || list_key.first != 'type'

        category_id = list_key[1]
        case value
        when 'update'
          category = Category.find_by(id: category_id)
          if category_id.blank? || category.blank?
            msg_errors << 'Đề mục này này đã không còn tồn tại!'
            next
          end

          if params[:"content@#{category_id}"] == category.content && params[:"status@#{category_id}"].to_i == category.status.to_i
            next
          end

          category.update!(
            event_id: params[:event_id],
            content: params[:"content@#{category_id}"],
            status: params[:"status@#{category_id}"].to_i,
            updated_at: Time.zone.now,
            user_id: current_user.id
          )
        when 'create'
          category = Category.find_by(id: category_id)
          if category_id.blank? || category.present?
            msg_errors << 'Có lỗi xảy ra!'
            next
          end

          next if params[:"content@#{category_id}"].blank?

          Category.create!(
            event_id: params[:event_id],
            content: params[:"content@#{category_id}"],
            status: params[:"status@#{category_id}"].to_i,
            created_at: Time.zone.now,
            user_id: current_user.id
          )
        end
      end
    end
    load_categories

    redirect_to categories_url(event_id: params[:event_id]), notice: 'Cập nhật sự kiện thành công!'
  rescue StandardError => e
    load_categories
    flash.alert = e.message + msg_errors.join('<br>')
    render :index
  end

  private

  def load_categories
    @event = Event.find_by(id: params[:event_id])
    @max_id = Category.maximum(:id).to_i

    if params[:event_id].blank? || @event.blank?
      @categories = []
      flash.alert = 'Url không hợp lệ!'
      return render(:index)
    end

    @categories = Category.where(event_id: params[:event_id], status: 1).order(created_at: :asc)
  end
end
