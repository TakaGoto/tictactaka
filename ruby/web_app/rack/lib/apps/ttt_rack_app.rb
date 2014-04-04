require 'erb'
require './lib/game_bind'
require './lib/rack_ui'
require './lib/presenters/board_presenter'
require 'taka_tic_tac_toe'

class TTTRackApp
  attr_reader :view, :bind

  def call(env)
    @bind = GameBind.new(env['board'], env['message'])
    @view = ERB.new(File.read(env['HTML_INFO'])).result(@bind.get_binding)
    [200, {"Content-Type" => "text/html"}, [@view]]
  end
end
