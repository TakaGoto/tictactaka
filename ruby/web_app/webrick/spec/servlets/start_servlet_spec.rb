require 'servlets/start_servlet'

describe StartServlet do
  let(:start) {described_class.new({})}
  let(:req)  {WEBrick::HTTPRequest.new({})}
  let(:resp) {WEBrick::HTTPResponse.new(:HTTPVersion => "1.0")}

  describe "#do_GET" do
    it "retrieves an rhtml file" do
      rhtml = ERB.new(File.read("./views/start.rhtml"))
      ERB.should_receive(:new).and_return(rhtml)
      File.should_receive(:read)
      start.do_GET(req, resp)
      start.template.should == rhtml
      start.template.class.should == ERB
    end
  end
end
