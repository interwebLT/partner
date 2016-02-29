class PartnersPage < SitePrism::Page
  set_url '/partners/'

  elements :partners, '#partners tbody tr'
end
