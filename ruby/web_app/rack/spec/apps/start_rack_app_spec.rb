require './lib/apps/start_rack_app'
require 'erb'

describe StartRackApp do
  describe "#call" do
    let(:app) {StartRackApp.new}
    let(:env) {{}}

    it 'returns an array' do
      app.call(env).should be_an(Array)
    end

    it 'should return an array of size 3' do
      app.call(env).size.should == 3
    end

    it 'reads in a file' do
      file = ERB.new(File.read('./views/start.html.erb')).result
      ERB.stub_chain(:new, :result).and_return(file)
      response = app.call(env)
      response[2].should == [file]
    end
  end
end
