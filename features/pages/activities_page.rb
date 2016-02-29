class ActivitiesPage < SitePrism::Page
  set_url '/activities'

  section :header, HeaderSection, 'header'

  elements :activities, '#activities tbody tr'
end
