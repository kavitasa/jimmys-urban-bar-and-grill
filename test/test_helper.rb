ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/spec'
require 'rack/test'
require 'sequel'
require 'capybara'
require 'capybara/dsl'
require_relative '../jimmys'
require 'dotenv'

Dotenv.load

Capybara.app = Jimmys

Jimmys.db = Sequel.connect(ENV['TEST_DATABASE_URL'])

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, headers: { 'User-Agent' => 'Capybara' })
end
