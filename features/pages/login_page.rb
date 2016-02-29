class LoginPage < SitePrism::Page
  set_url '/users/sign_in'

  element :username_field,  '#user_username'
  element :password_field,  '#user_password'
  element :login_button,    "input[name='commit']"

  def authenticate
    username_field.set 'alpha'
    password_field.set 'password'

    login_button.click
  end
end
