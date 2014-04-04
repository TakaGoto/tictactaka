require 'servlets/game_servlet'

describe GameServlet do
  let(:game) {described_class.new({})}
  let(:req)  {WEBrick::HTTPRequest.new({})}
  let(:resp) {WEBrick::HTTPResponse.new(:HTTPVersion => "1.0")}

  before(:each) do
    resp.cookies.push(Cookie.new("board", '3'))
    resp.cookies.push(Cookie.new("game_board", '123456789'))
    resp.cookies.push(Cookie.new("player_one", 'human'))
    resp.cookies.push(Cookie.new("player_two", 'computer'))
  end

  describe "#initialize" do
    it "has a settings hash" do
      game.settings.class.should == Hash
      game.settings.should == {}
    end

    it "redirects to 'start' if no settings" do
      game.do_GET(req, resp)
      resp.status.should == 200
    end
  end

  describe "#do_GET" do
    it "retrieves four cookies" do
      game.add_cookie(resp, "board",      "3",       '/game')
      game.add_cookie(resp, "game_board", '123456789','/game')
      game.add_cookie(resp, "player_one", "human",   '/game')
      game.add_cookie(resp, "player_two", "computer", '/game')

      game.should_receive(:add_cookie).exactly(4).times
      game.do_GET(req, resp)
    end

    it "plays the game" do
      settings = {:board => '3',
                  :player_one => 'human',
                  :player_two => 'human',
                  :game_board => "123456789"}
      new_game = TakaTicTacToe::Game.play_game(WEBrickUI, settings)
      TakaTicTacToe::Game.should_receive(:play_game).and_return(new_game)
      game.do_GET(req, resp)
    end

    it "sets respond body" do
      resp.should_receive(:body).and_return("hello world")
      game.do_GET(req, resp)
      resp.body.should == "hello world"
    end

    it "retrieves an rhtml file" do
      rhtml = ERB.new(File.read("./views/index.rhtml"))
      ERB.should_receive(:new).and_return(rhtml)
      File.should_receive(:read)
      game.do_GET(req, resp)
      game.template.should == rhtml
      game.template.class.should == ERB
    end

    it "assigns the rhtml to response body" do
      game.do_GET(req, resp)
      resp.body.include?("<head>").should be_true
    end
  end

  describe "#do_POST" do
    before(:each) do
      req.query['player_one'] = "1"
      game.should_receive(:get_cookie).and_return("123456789")
    end
  end

  describe "#add_cookie" do
    it "adds the cookie "do
      result = game.add_cookie(resp, "board", "3", '/game')
      result.should_not be_empty
      game.get_cookie(resp, "board").should == '3'
    end
  end

  describe "#get_cookie" do
    it "gets the cookie" do
      game.add_cookie(resp, "board", "123456789", '/game')
      game.do_GET(req, resp)
      game.get_cookie(resp, "board").should == "3"
    end

    it "should retrieve empty" do
      game.get_cookie(req, "board").should == []
    end

    it "retrieves the test cookie" do
      game.do_GET(req, resp)
      game.get_cookie(resp, "board").should == "3"
    end
  end
end

