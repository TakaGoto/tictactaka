require 'servlets/play_game_servlet'

describe PlayGameServlet do
  let(:player_move) {described_class.new({})}
  let(:req)  {WEBrick::HTTPRequest.new({})}
  let(:resp) {WEBrick::HTTPResponse.new(:HTTPVersion => "1.0")}

  def store_all_cookies(resp)
    resp.cookies.push(Cookie.new("game_board", '1234X6789'))
    resp.cookies.push(Cookie.new("board",      '3'))
    resp.cookies.push(Cookie.new("player_one", 'human'))
    resp.cookies.push(Cookie.new("player_two", 'computer'))
  end

  def get_cookie(resp, name)
    resp.cookies.each do |c|
      return c.value if c.name == name
    end
  end

  describe "do_POST" do
    it "plays the game" do
      req.query["player_move"] = "5"
      store_all_cookies(req)
      player_move.do_POST(req, resp)
      player_move.game.player_one.class.should == TakaTicTacToe::Human
      player_move.game.player_two.class.should == TakaTicTacToe::Computer
      player_move.game.board.length.should == 3
      player_move.game.board.to_s.should == 'O234X6789'
    end

    it "stores cookies" do
      req.query["player_move"] = "5"
      store_all_cookies(req)
      player_move.do_POST(req, resp)
      get_cookie(resp, "board").should == '3'
      get_cookie(resp, "player_one").should == 'human'
      get_cookie(resp, "player_two").should == 'computer'
    end
  end
end
