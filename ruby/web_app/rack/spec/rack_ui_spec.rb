require 'rack_ui'
require './spec/mocks/board_mock'
require 'taka_tic_tac_toe'

describe RackUI do
  describe "start_game" do
    it "displays a welcome message" do
      described_class.display_message
      described_class.messages[:message].include?("Have fun! Your move.").should be_true
    end

    it "has an instance messages" do
      described_class.messages.should be_a(Hash)
    end

    it "prints the board" do
      board = BoardMock.new
      described_class.print_board(board)
      board.slots.should be_true
    end

    it "asks for a move" do
      player = TakaTicTacToe::Human.new('X')
      described_class.ask_move(player).should == "Your move player one"
      described_class.messages[:message].should == "Your move player one"
    end
  end

  describe "end_game" do
    it "displays a winner" do
      described_class.display_result("O")
      described_class.messages[:message].should == "Winner is O"
    end

    it "displays a tie" do
      described_class.display_result("tie")
      described_class.messages[:message].should == "It is a tie!"
    end
  end

  it "displays an error" do
    described_class.error
    described_class.messages[:message].should == "Error"
  end
end
