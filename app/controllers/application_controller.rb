# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include UsersHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_data_navbar
  before_action :configure_permitted_parameters, if: :devise_controller?

  def load_data_navbar
    @events = Event.where(status: 1).order(:order)
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
