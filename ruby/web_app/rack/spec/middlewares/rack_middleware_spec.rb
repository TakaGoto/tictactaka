require 'apps/ttt_rack_app'
require 'rack'
require 'middlewares/rack_middleware'
require 'taka_tic_tac_toe'

describe RackMiddleware do
  let(:app)  {TTTRackApp.new}
  let(:rack) {RackMiddleware.new(app)}
  let(:env)  {{}}

  before(:each) do
    env['board'] = '123456789'
    env['message'] = 'Welcome'
    env['HTML_INFO'] = 'views/index.html.erb'
    allow_message_expectations_on_nil
  end

  describe "#initialize" do
    it "has an application" do
      rack.app.should_not be_nil
    end
  end

  describe "#get_start" do
    it "renders start.html.erb" do
      env['PATH_INFO'] = '/start'
      result = rack.call(env)
      result[0].should == 200
    end
  end

  describe "#get_player_move" do
    it 'makes a move' do
      req = Rack::MockRequest.new(env)
      settings = {:board => "3",
                  :game_board => env['board'],
                  :player_one => "human",
                  :player_two => "computer"}
      rack.req = req
      req.should_receive(:cookies)
      rack.should_receive(:store_all_cookies)
      rack.get_player_move(env, settings)
    end
  end

  describe "#store_all_cookies" do
    it 'stores all the cookies' do
      board = BoardMock.new
      params = {"board_size" => "3",
                "player_one" => "human",
                "player_two" => "computer"}

      resp = Rack::Response.new(["<html></html>", [200], {"Content-Type" => "text/html"}])

      rack.store_all_cookies(resp, board, params)

      resp.header["Set-Cookie"].should_not be_empty
    end
  end

  describe "#get_player_move" do
    it 'gets player move' do
      settings = {:board => "3",
                  :game_board => env['board'],
                  :player_one => "human",
                  :player_two => "computer"}
      req = Rack::MockRequest.new(env)
      rack.req = req
      rack.should_receive(:store_all_cookies)
      req.should_receive(:cookies)
      rack.get_player_move(env, settings)
    end
  end

  describe "#response" do
    it "creates a header body and status" do
      result = rack.call(env)
      result[0].should == 200
      result[1].should == {"Content-Type" => "text/html"}
    end
  end
end
