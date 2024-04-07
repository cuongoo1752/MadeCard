# Các hàm helper người dùng
module UsersHelper
  def role_user
    "user"
  end

  def role_admin
    "admin"
  end

  def is_admin? user
    user&.role == role_admin
  end

  def is_current_admin?
    current_user&.role == role_admin
  end

  def get_email_user user_id
    User.find_by(id: user_id)&.email
  end
end
