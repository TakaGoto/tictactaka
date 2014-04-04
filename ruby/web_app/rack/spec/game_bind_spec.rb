require 'game_bind'
require 'rack_ui'

describe GameBind do
  let(:board) {'123456789'}
  let(:message) {'This is a message'}
  let(:bind)  {described_class.new(board, message)}


  describe "#initialize" do
    it "has a board" do
      bind.board.class.should == String
      bind.board.should == '123456789'
    end

    it "has a message variable" do
      bind.message.should == "This is a message"
    end
  end

  describe "#binding" do
    it "returns binding" do
      bind.get_binding
      bind.binded.should be_true
    end
  end
end
