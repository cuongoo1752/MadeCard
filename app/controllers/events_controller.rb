class EventsController < ApplicationController
  include ApplicationHelper
  include UsersHelper
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events or /events.json
  def index
    load_events
  end

  def list_wishes
    @event = Event.where(id: params[:id]).first
    @categories = Category.where(event_id: @event.id)
  end

  def update_all
    msg_errors = []

    ActiveRecord::Base.transaction do
      params.each do |key, value|
        next if value.blank?

        list_key = key.split('@')

        next if list_key.size != 2 || list_key.first != 'type'

        event_id = list_key[1]
        case value
        when 'update'
          event = Event.find_by(id: event_id)
          if event_id.blank? || event.blank?
            msg_errors << 'Sự kiện này đã không còn tồn tại!'
            next
          end

          if params[:"content@#{event_id}"] == event.content && params[:"status@#{event_id}"].to_i == event.status.to_i
            next
          end

          event.update!(
            content: params[:"content@#{event_id}"],
            status: params[:"status@#{event_id}"].to_i,
            updated_at: Time.zone.now,
            user_id: current_user.id
          )
        when 'create'
          event = Event.find_by(id: event_id)
          if event_id.blank? || event.present?
            msg_errors << 'Có lỗi xảy ra!'
            next
          end

          next if params[:"content@#{event_id}"].blank?

          Event.create!(
            content: params[:"content@#{event_id}"],
            status: params[:"status@#{event_id}"].to_i,
            created_at: Time.zone.now,
            user_id: current_user.id
          )
        end
      end
    end
    load_events

    redirect_to events_url, notice: 'Cập nhật sự kiện thành công!'
  rescue StandardError => e
    load_events
    render :index, notice: e.message
  end

  private

  def load_events
    @events = Event.where(status: 1).order(created_at: :asc)
    @max_id = Event.maximum(:id).to_i
  end
end
