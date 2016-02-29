class ReportsPage < SitePrism::Page
  set_url '/reports'

  elements :orders, '#orders tbody tr'
  elements :credits, '#credits tbody tr'
end
