module ApplicationHelper
  def create_params
    {
      status: 1,
      created_at: Time.zone.now
    }
  end

  def update_params
    {
      status: 1,
      updated_at: Time.zone.now
    }
  end

  def delete_params
    {
      status: 9,
      updated_at: Time.zone.now
    }
  end

  def get_max_order table
    table.maximum(:order).to_i + 2
  end

  def get_user_id_request
    User.find_by(status: 999).id
  end
end
