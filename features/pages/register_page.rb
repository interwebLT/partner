class RegisterPage < SitePrism::Page
  set_url '/register'
  set_url_matcher /\/register$/

  element :domain_name, '#domain_name'

  element :submit, "input[name='commit']"

  def registrant
    @registrant ||= Register::RegistrantPage.new
  end
end
