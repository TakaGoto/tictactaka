require 'webrick'

include WEBrick

class WEBrickTTT
  attr_reader :server

  def initialize(config={})
    config.update(:Port => 4567)
    @server = HTTPServer.new(config)
    yield @server if block_given?
  end

  def start
    ['INT', 'TERM'].each {|signal| trap(signal) {server.shutdown}}
    @server.start
  end

  def shutdown
    @server.shutdown
  end
end

if $0 == __FILE__ then
  require './lib/servlets/game_servlet'
  require './lib/servlets/start_servlet'
  require './lib/servlets/play_game_servlet'
  web = WEBrickTTT.new{|server| server.mount('/', StartServlet)
                                server.mount('/game', GameServlet)
                                server.mount('/player_move', PlayGameServlet)}
  web.start
end


