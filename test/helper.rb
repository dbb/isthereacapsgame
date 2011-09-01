# vi: set fileencoding=utf-8 :
ENV['RACK_ENV'] = 'test'
require 'bundler'
Bundler.setup
Bundler.require(:development, :test)

gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'redgreen'
require 'rack/test'
require 'nokogiri'
require_relative '../caps'

class TestCapsApp < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Caps
  end
end
