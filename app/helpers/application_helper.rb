module ApplicationHelper
  def create_display_only_button type, message, action = nil
    render partial: "shared/display_buttons", locals: {type: type, message: message, action: action}
  end
end
