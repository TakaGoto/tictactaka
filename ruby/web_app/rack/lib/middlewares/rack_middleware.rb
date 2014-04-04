require 'taka_tic_tac_toe'
require './lib/rack_ui'

class RackMiddleware
  include TakaTicTacToe

  attr_reader :app
  attr_accessor :req

  def initialize(app)
    @app = app
  end

  def call(env)
    @req = Rack::Request.new(env)
    if path?(env, '/game') && @req.post?
      board = post_game(env)
      get_game(env, board)
    elsif path?(env, '/player_move')
      post_player_move(env)
    else
      set_html_page(env, 'views/start.html.erb')
      status, headers, body = @app.call(env)
    end
  end

  def post_player_move(env)
    set_html_page(env, 'views/index.html.erb')

    settings = get_settings(@req.cookies, @req.cookies["game_board"])

    game = Game.play_game(RackUI, settings, @req.params["player_move"])

    settings[:game_board] = game.board.to_blanks
    get_player_move(env, settings)
  end

  def get_player_move(env, settings)
    game = Game.play_game(RackUI, settings)

    setup_board_and_message(game, env)
    status, headers, body = @app.call(env)

    @resp = Rack::Response.new(body, status, headers)
    store_all_cookies(@resp, game.board, @req.cookies)
  end

  def post_game(env)
    board = Board.new
    board.board_size(@req.params["board"].to_i)
    board
  end

  def get_game(env, board)
    set_html_page(env, 'views/index.html.erb')

    settings = get_settings(@req.params, board.to_blanks)

    game = Game.play_game(RackUI, settings)

    setup_board_and_message(game, env)

    status, headers, body = @app.call(env)

    @resp = Rack::Response.new(body, status, headers)
    store_all_cookies(@resp, game.board, @req.params)
  end

  def setup_board_and_message(game, env)
    env['board'] = game.board.to_blanks
    env['message'] = game.ui.messages[:message]
  end

  def path?(env, path)
    env['PATH_INFO'] == path
  end

  def set_html_page(env, file)
    env['HTML_INFO'] = file
  end

  def store_all_cookies(resp, game_board, params)
    resp.set_cookie("board",      :value => params["board"], :path => "/player_move")
    resp.set_cookie("game_board", :value => game_board.to_blanks, :path => "/player_move")
    resp.set_cookie("player_one", :value => params["player_one"], :path => "/player_move")
    resp.set_cookie("player_two", :value => params["player_two"], :path => "/player_move")
    resp.finish
  end

  def get_settings(params, board)
    settings = {}
    settings[:board] =      params["board"]
    settings[:game_board] = board
    settings[:player_one] = params["player_one"]
    settings[:player_two] = params["player_two"]
    settings
  end
end
