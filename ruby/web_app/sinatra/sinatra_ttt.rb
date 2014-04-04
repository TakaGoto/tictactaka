require 'sinatra'
require './lib/presenters/board_presenter'
require './lib/presenters/ttt_option_presenter'
require './lib/sinatra_ui'
require 'bundler'
Bundler.require

include TakaTicTacToe
helpers Sinatra::Cookies

get '/' do
  erb :index
end

get '/game' do

  redirect '/' if cookies.empty?

  @game = Game.play_game(SinatraUI, cookies)

  response.set_cookie("game_board",{:value => @game.board.to_blanks, :path => '/player_move'})
  response.set_cookie("player_one",{:value => cookies[:player_one], :path => '/player_move'})
  response.set_cookie("player_two",{:value => cookies[:player_two], :path => '/player_move'})
  response.set_cookie("board",     {:value => cookies[:board], :path => '/player_move'})

  erb :start
end

post '/game' do

  board = Board.new
  board.board_size(params["board_size"].to_i)

  response.set_cookie("game_board",{:value => board.to_blanks, :path => '/game'})
  response.set_cookie("player_one",{:value => params["player_one"], :path => '/game'})
  response.set_cookie("player_two",{:value => params["player_two"], :path => '/game'})
  response.set_cookie("board",     {:value => params["board_size"], :path => '/game'})

  redirect '/game'
end

post '/player_move' do

  @game = Game.play_game(SinatraUI, cookies, params[:player_move])

  response.set_cookie("game_board",{:value => @game.board.to_blanks, :path => '/game'})
  response.set_cookie("player_one",{:value => cookies[:player_one], :path => '/game'})
  response.set_cookie("player_two",{:value => cookies[:player_two], :path => '/game'})
  response.set_cookie("board",     {:value => cookies[:board], :path => '/game'})

  redirect '/game'
end
