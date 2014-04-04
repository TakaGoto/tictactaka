require 'erb'
require './lib/webrick_ui'
require './lib/presenters/game_presenter'
require './lib/webrick_server'
require 'bundler'
Bundler.require

class GameServlet < HTTPServlet::AbstractServlet
  include TakaTicTacToe

  attr_reader :settings, :template, :game

  def initialize(config, *options)
    @settings = {}
  end

  def do_GET(req, resp)

    @settings = get_settings(resp)

    if @settings[:board].empty?
      resp.set_redirect(WEBrick::HTTPStatus::MovedPermanently, "/")
    end

    @game = Game.play_game(WEBrickUI, settings)

    @template = ERB.new(File.read('./views/index.rhtml'))
    resp.body = @template.result(binding)

    store_all_cookies(resp, @game.board, req.query, '/player_move')
  end

  def do_POST(req, resp)
    board = Board.new
    board.board_size(req.query["board_size"].to_i)

    store_all_cookies(resp, board, req.query, '/game')

    do_GET(req, resp)
  end

  def get_settings(resp)
    settings = {}
    settings[:board]      = get_cookie(resp, "board")
    settings[:game_board] = get_cookie(resp, "game_board")
    settings[:player_one] = get_cookie(resp, "player_one")
    settings[:player_two] = get_cookie(resp, "player_two")
    settings
  end

  def store_all_cookies(resp, game_board, params, path)
    add_cookie(resp, "board",      params["board_size"], path)
    add_cookie(resp, "game_board", game_board.to_blanks, path)
    add_cookie(resp, "player_one", params["player_one"], path)
    add_cookie(resp, "player_two", params["player_two"], path)
  end

  def get_cookie(req, name)
    req.cookies.each do |c|
      if c.name == name
        return c.value
      end
    end
  end

  def add_cookie(resp, name, value, path)
    cookie = Cookie.new(name, value)
    cookie.path = path
    resp.cookies.push(cookie)
  end
end
