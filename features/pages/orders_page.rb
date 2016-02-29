class OrdersPage < SitePrism::Page
  set_url '/orders'

  section :header, HeaderSection, 'header'

  elements :orders, '#orders tbody tr'
end
