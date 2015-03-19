class SecureController < ApplicationController
  before_filter :authenticate_user!

  def except_admin
    (not current_user.admin) || resource_not_found
  end

  def admin_only
    current_user.admin || resource_not_found
  end

  def staff_only
    current_user.staff || resource_not_found
  end
end
