class AddDomainHostPage < SitePrism::Page
  set_url '/domains/{id}/hosts'

  element :name,    "input[name='domain_host[name]']"
  element :submit,  '#submit'
end
