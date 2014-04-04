require 'sinatra/cookies'
require 'mocks/board_mock'
require 'spec_helper'
require './sinatra_ttt'

def set_cookies
  set_cookie("game_board=123456789")
  set_cookie("board=3")
  set_cookie("player_one=human")
  set_cookie("player_two=computer")
end

describe "sinatra tic tac toe" do
  let(:game)  {TakaTicTacToe::Game.new(SinatraUI,
                                       {:game_board => "123456789",
                                        :player_one => "human",
                                        :player_two => "computer",
                                        :board => "3"})}

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before :each do
    clear_cookies
  end

  describe "routes" do
    describe "POST '/game'" do
      it "creates the board from board option" do
        board = BoardMock.new
        TakaTicTacToe::Board.should_receive(:new).and_return(board)
        board.should_receive(:board_size)
        post '/game', {:board_size => 3, :player_one_option => :human, :player_two_option => :computer}

        board.changed_to_blanks.should be_true
      end

      it "should start a new game" do
        settings = {:board => 3, :player_one => :human, :player_two => :computer}
        post '/game', {:board_size => 3, :player_one_option => :human, :player_two_option => :computer}
      end

      it "redirects to '/' if cookies are empty" do
        clear_cookies
        get '/game'
        last_response.should be_redirect
        follow_redirect!
        last_request.url.should == 'http://example.org/'
      end

      it "sets the initial cookie" do
        post '/game', {"board_size" => "3", "player_one" => :human, "player_two" => :computer}
        get '/game'
        last_request.cookies.should == {"game_board" => "_________",
                                        "player_one" => "human",
                                        "player_two" => "computer",
                                        "board" => "3"}
      end
    end

    describe "GET '/game'" do
      it "plays the game " do
        set_cookies
        TakaTicTacToe::Game.should_receive(:play_game).and_return(game)
        get '/game'
        game.board.length.should == 3
        game.player_one.class.should == TakaTicTacToe::Human
        game.player_two.class.should == TakaTicTacToe::Computer
      end

      it "has a player_one in the cookie jar" do
        set_cookies
        get '/game'
        rack_mock_session.cookie_jar["player_one"].should == "human"
      end

      it "has a board in the cookie jar" do
        set_cookies
        get '/game'
        rack_mock_session.cookie_jar["player_two"].should == "computer"
      end

      it "has a board in the cookie jar" do
        set_cookies
        get '/game'
        rack_mock_session.cookie_jar["board"].should == "3"
      end

      it "has the board" do
        set_cookies
        get '/game'
        last_request.cookies["game_board"].should == "123456789"
      end
    end

    describe "POST 'player_move'" do

      it "plays the game" do
        set_cookies
        TakaTicTacToe::Game.should_receive(:play_game).and_return(game)
        post '/player_move', {:player_move => "5"}
        game.player_one.class.should == TakaTicTacToe::Human
      end

      it "has a player_one in the cookie jar" do
        set_cookies
        post '/player_move', {:player_move => "3"}
        rack_mock_session.cookie_jar["player_one"].should == "human"
      end

      it "has a board in the cookie jar" do
        set_cookies
        post '/player_move', {:player_move => "3"}
        rack_mock_session.cookie_jar["player_two"].should == "computer"
      end

      it "has a board in the cookie jar" do
        set_cookies
        post '/player_move', {:player_move => "3"}
        rack_mock_session.cookie_jar["board"].should == "3"
      end
    end
  end
end
