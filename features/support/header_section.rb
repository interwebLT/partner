class HeaderSection < SitePrism::Section
  element :menu_orders, '#menu_orders'
  element :menu_activities, '#menu_activities'

  element :menu_replenish_credits, '#menu_replenish_credits'
  element :menu_partner_info, '#menu_partner_info'

  element :current_balance, '#current_balance'

  element :banner_title, '#banner-title div div h2'
end
