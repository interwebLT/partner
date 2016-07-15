class RegisterPage < SitePrism::Page
  set_url '/register'

  element :notice,  '#notice'
  element :alert,   '#alert'

  element :domain_name, '#domain_name'

  element :domain_name, '#reg-new-domain-text-area'

  element :submit, "input[name='commit']"

  def details
    @details ||= Register::DetailsPage.new
  end

  def summary
    @summary ||= Register::SummaryPage.new
  end
end
