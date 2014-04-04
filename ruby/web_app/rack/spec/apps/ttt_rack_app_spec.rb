require 'taka_tic_tac_toe'
require './lib/game_bind'
require './lib/apps/ttt_rack_app'
require './lib/rack_ui'

describe TTTRackApp do
  describe "#call" do
    let(:app) {TTTRackApp.new}
    let(:env) {{}}

    before(:each) do
      env['board'] = '123456789'
      env['message'] = 'hello'
      env['HTML_INFO'] = './views/index.html.erb'
      bind = GameBind.new(env['board'], env['message'])
      GameBind.should_receive(:new).with(env['board'], env['message']).and_return(bind)
    end

    it "returns an array" do
      app.call(env).should be_an(Array)
    end

    it "should return an array of size 3" do
      app.call(env).size.should == 3
    end

    it "calls binding" do
      app.call(env)
      app.bind.class.should == GameBind
      app.bind.binded.should be_true
    end
  end
end
