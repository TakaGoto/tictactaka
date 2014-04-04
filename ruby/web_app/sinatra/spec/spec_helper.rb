require 'mocks/board_mock'
require 'bundler'
require './lib/sinatra_ui'
require './lib/presenters/ttt_option_presenter.rb'
Bundler.require(:test)


RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
