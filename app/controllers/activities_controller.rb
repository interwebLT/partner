class ActivitiesController < SecureController
  def index
    if !params[:domain_id].nil?
      page = params[:activity_page].nil? ? 1 : params[:activity_page]
      @activities = Domain.get_activities params[:domain_id], page, current_user.token
    else
      if current_user.admin
        @activities = ObjectActivity.all token: current_user.token
      end
    end
  end
end
