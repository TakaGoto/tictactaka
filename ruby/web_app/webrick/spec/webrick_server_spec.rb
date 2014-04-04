require './lib/webrick_server'

describe WEBrickTTT do
  before(:all) do
    @web = WEBrickTTT.new(:DocumentRoot => '/www')
  end
  describe "#initialize" do
    it "sets up a server" do
      @web.server.class.should == WEBrick::HTTPServer
      @web.server.status.should == :Stop
    end
  end

  describe "#start" do
    it "starts the server" do
      thread = Thread.new { @web.start }
      loop do
        sleep 0.5
        break if @web.server.status != :Stop
      end
      @web.server.status.should == :Running
      @web.shutdown
      thread.join
    end
  end
end

