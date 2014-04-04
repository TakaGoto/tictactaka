require './lib/apps/ttt_rack_app'
require './lib/apps/start_rack_app'
require './lib/middlewares/rack_middleware'
require 'bundler'
Bundler.require(:default)

use Rack::Reloader
use RackMiddleware

map '/' do
  run StartRackApp.new
end

map '/game' do
  run TTTRackApp.new
end

map '/player_move' do
  run TTTRackApp.new
end



