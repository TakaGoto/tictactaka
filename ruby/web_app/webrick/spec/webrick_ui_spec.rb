require './lib/webrick_ui'
require 'mocks/board_mock'

describe WEBrickUI do
  describe "#display_message" do
    it "displays the initial message" do
      described_class.display_message
      described_class.messages[:message].should == "Your move! Have fun!"
    end
  end

  describe "#print_board" do
    it "prints out a board" do
      board = BoardMock.new
      described_class.print_board(board)
      board.slots.should be_true
    end
  end

  describe "#error" do
    it "displays an error" do
      described_class.error
      described_class.messages[:message].should == "Error"
    end
  end

  describe "#display_result" do
    it "displays a tie" do
      described_class.display_result("tie")
      described_class.messages[:message].should == "It is a tie!"
    end

    it "displays a win" do
      described_class.display_result("X")
      described_class.messages[:message].should == "Winner is X"
    end
  end
end
