class LoginPage < SitePrism::Page
  set_url '/users/sign_in'

  element :alert, '#alert'

  element :username,  '#user_username'
  element :password,  '#user_password'
  element :login,     "input[name='commit']"

  def authenticate
    username.set 'alpha'
    password.set 'password'

    login.click
  end
end
