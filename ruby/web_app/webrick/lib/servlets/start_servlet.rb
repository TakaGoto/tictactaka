require 'webrick'
require 'taka_tic_tac_toe'
require './lib/servlets/game_servlet'
require './lib/webrick_server'
require './lib/webrick_ui'

class StartServlet < HTTPServlet::AbstractServlet
  attr_reader :template

  def do_GET(req, resp)
    @template = ERB.new(File.read("./views/start.rhtml"))
    resp.body = @template.result(binding)
  end
end
