require './lib/webrick_ui'
require './lib/servlets/game_servlet'
require './lib/presenters/game_presenter'
require './lib/presenters/ttt_option_presenter'
require './lib/webrick_server'
require 'bundler'
Bundler.require

class PlayGameServlet < HTTPServlet::AbstractServlet
  include TakaTicTacToe

  attr_reader :game

  def do_GET(req, resp)

    settings = get_settings(resp)
    @game = Game.play_game(WEBrickUI, settings)

    @template = ERB.new(File.read('./views/index.rhtml'))
    resp.body = @template.result(binding)

    store_all_cookies(resp, @game.board, settings)
  end

  def do_POST(req, resp)
    settings = get_settings(req)

    @game = Game.play_game(WEBrickUI, settings, req.query["player_move"])

    store_all_cookies(resp, @game.board, settings)

    do_GET(req, resp)
  end

  def store_all_cookies(resp, game_board, params)
    add_cookie(resp, "board",      params[:board])
    add_cookie(resp, "game_board", game_board.to_blanks)
    add_cookie(resp, "player_one", params[:player_one])
    add_cookie(resp, "player_two", params[:player_two])
  end


  def get_cookie(req, name)
    req.cookies.each {|c| return c.value if c.name == name}
  end

  def add_cookie(resp, name, value)
    cookie = Cookie.new(name, value)
    cookie.path = '/player_move'
    resp.cookies.push(cookie)
  end

  def get_settings(resp)
    settings = {}
    settings[:board]      = get_cookie(resp, "board")
    settings[:game_board] = get_cookie(resp, "game_board")
    settings[:player_one] = get_cookie(resp, "player_one")
    settings[:player_two] = get_cookie(resp, "player_two")
    settings
  end
end
