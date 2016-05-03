class AddDomainHostPage < SitePrism::Page
  set_url '/domains/{id}/hosts'

  element :warning, '#warning'

  element :name,    "input[name='domain_host[name]']"
  element :submit,  '#submit'
end
