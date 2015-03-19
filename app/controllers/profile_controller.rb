class ProfileController < SecureController
  def index
    @partner = current_user.partner
  end
end
