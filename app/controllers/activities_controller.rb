class ActivitiesController < SecureController
  def index
    if !params[:domain_id].nil?
      @activities = Domain.get_activities params[:domain_id], current_user.token
    else
      if current_user.admin
        @activities = ObjectActivity.all token: current_user.token
      end
    end
  end
end
