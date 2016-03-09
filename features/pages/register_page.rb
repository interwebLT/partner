class RegisterPage < SitePrism::Page
  set_url '/register'

  element :notice,  '#notice'
  element :alert,   '#alert'

  element :domain_name, '#domain_name'

  element :submit, "input[name='commit']"

  def details
    @details ||= Register::DetailsPage.new
  end
end
