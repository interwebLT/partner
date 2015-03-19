class ActivitiesController < SecureController
  def index
    @activities = ObjectActivity.all token: current_user.token
  end
end
