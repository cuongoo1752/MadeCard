class User < ApplicationRecord
  include ApplicationHelper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_create :set_defaults

  private

  def set_defaults
    self.role ||= "user"
    self.status ||= 1
    self.order ||= get_max_order(User)
  end
end
