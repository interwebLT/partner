class LoginPage < SitePrism::Page
  set_url '/users/sign_in'
  set_url_matcher /\/users\/sign_in$/

  element :username_field,  '#user_username'
  element :password_field,  '#user_password'
  element :login_button,    "input[name='commit']"

  def authenticate
    username_field.set 'alpha'
    password_field.set 'password'

    login_button.click
  end
end

def staff_authenticated
  authenticate_user staff: true
end

def partner_authenticated
  authenticate_user
end

def admin_authenticated
  authenticate_user admin: true
end

def assert_authentication_prompted
  site.login.displayed?.must_equal true
end

def assert_partner_homepage_displayed
  assert_homepage_dispalyed
end

def assert_admin_homepage_displayed
  assert_homepage_dispalyed admin: true
end

def assert_homepage_dispalyed admin: false
  site.domains.displayed?.must_equal true

  site.domains.header.has_current_balance?.wont_equal admin
  site.domains.header.has_menu_partner_info?.wont_equal admin
end

private

def authenticate_user admin: false, staff: true
  stub_post to: Authorization.url, returns: token_response
  stub_get  to: User.url,   returns: user_response(admin: admin, staff: staff)
  stub_get  to: Domain.url, returns: []

  site.login.load
  site.login.authenticate
end

def token_response
  {
    token: 'ABCDEF'
  }
end

def user_response admin: false, staff: true
  {
    id: 1,
    username: 'alpha',
    partner_id: 1,
    token: 'abcd123456',
    partner_name: 'alpha',
    credits: 1000.00,
    admin: admin,
    staff: staff
  }
end
