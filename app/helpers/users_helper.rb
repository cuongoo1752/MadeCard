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
end
