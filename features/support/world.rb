require 'capybara'
require 'capybara/cucumber'
require 'site_prism'

require 'minitest/spec'

World(MiniTest::Assertions)
MiniTest::Spec.new(nil)

require 'webmock/cucumber'
