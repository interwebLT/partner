class ProfilePage < SitePrism::Page
  set_url '/profile'

  elements :default_nameservers, '#default_nameservers tbody tr'
end
