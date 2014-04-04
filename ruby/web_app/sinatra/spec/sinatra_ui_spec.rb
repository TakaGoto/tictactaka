require 'mocks/board_mock'
require 'spec_helper'

describe SinatraUI do
  describe "start_game" do
    it "displays a welcome message" do
      described_class.display_message
      described_class.messages[:message].include?("Have fun! Your move.").should be_true
    end

    it "prints the board" do
      board = BoardMock.new
      described_class.print_board(board)
      board.slots.should be_true
    end

    it "asks for a move" do
      settings = {:board => 3,
                  :player_one => :human,
                  :player_two => :computer}
      game = TakaTicTacToe::Game.new(described_class, settings)
      described_class.ask_move(game.player_one).should == "Your move player one"
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
