require 'spec_helper'
require 'tic_tac_toe/mocks/ui_mock'

describe TakaTicTacToe::Game do
  let(:ui) {UiMock.new}
  let(:settings) {{:board => 3, :player_one => :human, :player_two => :computer}}
  let(:game) {described_class.new(ui, settings)}

  describe "#game_settings" do
    before(:each) do
      game.game_settings({:player_two => :human, :player_one => :computer, :board => 4})
    end

    it "turns string board size into int" do
      game.game_settings({:player_two => "human", :player_one => "computer",
                          :board => "3"})
      game.board.slots.count.should == 9
    end

    it "turns strings into symbols" do
      game.game_settings({:player_two => "human", :player_one => "computer",
                          :board => 3})
      game.player_one.class.should == TakaTicTacToe::Computer
      game.player_two.class.should == TakaTicTacToe::Human
    end

    it "creates player one" do
      game.player_one.class.should == TakaTicTacToe::Computer
    end

    it "creates player two" do
      game.player_two.class.should == TakaTicTacToe::Human
    end

    it "creates a board" do
      game.board.slots.count.should == 16
    end
  end

  describe "#ask_player_one_type" do
    it "should ask for what type of player is player one" do
      TakaTicTacToe::PlayerFactory.stub(:create)
      game.ask_player_one_type
      ui.asked_player_one_type.should be_true
    end

    it "creates a computer player for player one" do
      game.ui.should_receive(:ask_player_one_type).and_return(:computer)
      game.ask_player_one_type
      game.player_one.class.should == TakaTicTacToe::Computer
    end
  end

  describe "#ask_player_two_type" do
    it "should ask for what type of player is player two" do
      TakaTicTacToe::PlayerFactory.stub(:create)
      game.ask_player_two_type
      ui.asked_player_two_type.should be_true
    end

    it "creates a human player for player two" do
      game.ui.should_receive(:ask_player_two_type).and_return(:human)
      game.ask_player_two_type
      game.player_two.class.should == TakaTicTacToe::Human
    end
  end

  describe "#is_over?" do
    it "returns true when tie" do
      game.set_slots("XOXOXOOXO")
      game.is_over?.should be_true
    end
  end

  describe "#continue?" do
    it "plays game again" do
      game.stub(:is_tie).and_return(true)
      game.start
      ui.ask_continue.should be_true
      game.over.should be_true
    end
  end

  describe "#initialize" do
    it "sets the game settings " do
      settings = {:board => 4, :player_one => :computer, :player_two => :human}
      game = TakaTicTacToe::Game.new(ui, settings)
      game.board.slots.count.should == 16
      game.player_one.class.should == TakaTicTacToe::Computer
      game.player_two.class.should == TakaTicTacToe::Human
    end

    it "has a board" do
      game.board.class.should == TakaTicTacToe::Board
    end

    it "has player_one and player_two" do
      game.player_one.mark.should_not be_nil
      game.player_two.mark.should_not be_nil
    end
  end

  describe "#result" do
    it "returns 'X'" do
      game.set_slots('XXX456789')
      game.result.should == "X"
    end

    it "returns a tie" do
      game.set_slots('XOXOXOOXO')
      game.result.should == "tie"
    end

    it "returns 'O'" do
      game.set_slots('OOO456789')
      game.result.should == "O"
    end
  end

  describe "#board_option" do
    it 'asks for board option until user inputs 3 or 4' do
      game.board_option
      ui.asked_board_option.should be_true
    end

    it "asks for board option" do
      game.board_option
      ui.asked_board_option.should be_true
    end

    it "should initialize the board" do
      game.board_option
      game.board.should be_a(TakaTicTacToe::Board)
    end

    it "retrieves the board option" do
      ui.should_receive(:ask_board_option).and_return(4)
      game.board_option
      game.board.slots.count.should == 16
    end
  end

  describe "#start" do
    before(:each) do
      game.stub(:has_winner).and_return(true)
    end

    it "prints board after game is over" do
      game.set_slots('XXX456789')
      game.start
      game.ui.board_printed.should be_true
    end

    it "prints out the board after the end of the game" do
    end

    it "asks for both players type" do
      game.start
      ui.asked_player_one_type.should be_true
      ui.asked_player_two_type.should be_true
    end

    describe "#board_option" do
      it "asks for a board options" do
        game.start
        ui.asked_board_option.should be_true
      end
    end

    it "displays message" do
      game.start
      ui.displayed_message.should be_true
    end

    it "displays end game message" do
      game.start
      ui.end_game_message.should be_true
    end

    it "prints the board" do
      game.start
      ui.board_printed.should be_true
    end
  end

  describe "#new" do
    it "retrieves the ui" do
      game.ui.class.should == UiMock
    end

    it "has players" do
      game.player_one.should_not be_nil
      game.player_two.should_not be_nil
    end
  end

  it "can set a new board" do
    game.set_slots('1234X6789')
    game.board.slots.should == ["1", "2", "3", "4", "X", "6", "7", "8", "9"]
  end

  context "#has_winner" do
    it "has a winner" do
      game.set_slots('OOO456789')
      game.has_winner.should be_true
    end

    it "does not have a winner" do
      game.set_slots('OXO456789')
      game.has_winner.should be_false
    end

    it "has a winner for 4x4 board" do
      game.board.board_size(4)
      game.board.set_move('X', 1, 2, 3, 4)
      game.has_winner.should be_true
    end

    it "shouldnt be winner for 4x4 board" do
      game.board.board_size(4)
      game.board.set_move('X', 1, 2, 3)
      game.has_winner.should be_false
    end
  end

  context "#unique?" do
    it "is not unique" do
      game.set_slots('123456789')
      game.unique?([1, 2, 3]).should be_false
    end

    it "is unique" do
      game.set_slots('OOO456789')
      game.unique?([1, 2, 3]).should be_true
    end

    it "is unique for 4x4 board" do
      game.board.board_size(4)
      game.board.set_move('X', 1, 2, 3, 4)
      game.unique?([1, 2, 3, 4]).should be_true
    end

    it "is unique for 4x4 board" do
      game.board.board_size(4)
      game.board.set_move('X', 3, 7, 11, 15)
      game.board.set_move('O', 2, 6, 10)
      game.unique?([3, 7, 11, 15]).should be_true
    end

    it "is unique for 4x4 board" do
      game.set_slots('________________')
      game.board.set_move('X', 1, 2, 3, 8, 16)
      game.board.set_move('O', 5, 6, 7, 11)
      game.is_over?.should be false
    end
  end

  context "#is_tie" do
    it "returns true for tie" do
      game.set_slots('OXXXXOOOX')
      game.is_tie.should be_true
    end
  end

  context "#winner" do
    it 'returns X' do
      game.set_slots('XO3XX6XOO')
      game.winner.should == 'X'
    end

    it "returns X when the winner is x" do
      game.set_slots('XXX456789')
      game.winner.should == 'X'
    end

    it "returns X with 4x4 board" do
      game.board.board_size(4)
      game.board.set_move('X', 1, 2, 3, 4)
      game.winner.should == 'X'
    end

    it 'returns O with 4x4 board' do
      game.board.board_size(4)
      game.board.set_move('O', 1, 6, 11, 16)
      game.winner.should == 'O'
    end

    it "should return ''" do
      game.board.board_size(4)
      game.board.set_move('X', 1, 2, 3)
      game.winner.should == ""
    end
  end

  describe "display result" do
    it "is a tie" do
      game.should_receive(:is_over?).and_return(true)
      game.start
      game.ui.displayed_result.should be_true
    end
  end

  describe "valid?" do
    it "is a valid move" do
      game.valid?("5").should be_true
    end

    it "is not a valid move" do
      game.set_slots('1234X6789')
      game.valid?("5").should be_false
    end
  end

  describe "#find_turn" do
    it "returns 'X'" do
      player = game.find_player('_________')
      player.should == game.player_one
    end

    it "returns 'O'" do
      player = game.find_player('X________')
      player.should == game.player_two
    end

    it "returns 'X' after moves" do
      player = game.find_player('XO_______')
      player.should == game.player_one
    end

    it "returns 'X' for 4x4 board" do
      player = game.find_player('XO______________')
      player.should == game.player_one
    end
  end

  describe "#play_game" do
    let(:settings) {{:board => 3, :player_one => :computer,
                    :player_two => :human,
                    :game_board => '_________'}}

    it 'checks if the game is over when play makes a move' do
      settings[:player_one] = :human
      settings[:player_two] = :computer
      settings[:game_board] = 'OO3XX678X'
      game = described_class.play_game(ui, settings)
      game.board.to_s.should == 'OOOXX678X'
      game.over.should be_true
    end

    it "asks player for a move" do
      settings[:game_board] = '1234X6789'
      described_class.play_game(ui, settings)
      ui.asked_move.should be_true
    end

    it "doesnt force human to make move if h vs h" do
      settings[:player_one] = :human
      new_game = described_class.play_game(ui, settings, "5")
      new_game.board.to_s.should == '1234X6789'
    end

    it "ends game when game is over" do
      settings[:game_board] = 'XXX456789'
      new_game = described_class.play_game(ui, settings)
      new_game.over.should be_true
    end

    describe "when its first player(X) turn" do
      it "makes a move if computer is first and board is empty" do
        new_game = described_class.play_game(ui, settings)
        new_game.board.to_s.should == 'X23456789'
        player = game.find_player(new_game.board.to_s)
        player.should == game.player_two
      end

      it "does not make a move when game is done" do
        settings[:game_board] = 'OOO456789'
        new_game = described_class.play_game(ui, settings)
        new_game.board.to_s.should == 'OOO456789'
      end

      it "makes human move for first player" do
        settings[:player_one] = :human
        new_game = described_class.play_game(ui, settings, "5")
        new_game.board.to_s.should == '1234X6789'
      end
    end

    describe "when its second player(O) turn" do
      it "makes a move for computer on second turn" do
        settings[:player_one] = :human
        settings[:player_two] = :computer
        settings[:game_board] = '1234X6789'
        new_game = described_class.play_game(ui, settings)
        new_game.board.to_s.should == 'O234X6789'
      end
    end
  end

  describe "#set_move" do
    it "sets the move on the board" do
      game.set_move('X', "1")
      game.board.slots.should == ["X", "2", "3", "4", "5", "6", "7", "8", "9"]
    end
  end

  describe "#make_player_moves" do
    it 'should receive output' do
      game.ui.should_receive(:ask_move).and_return(-1, 1)
      game.ui.output.should_receive(:puts)
      game.ask_move(game.player_one)
    end

    it "prints the board only once when the game is over and its human vs human" do
      game.ui.should_receive(:ask_move).once
      game.player_two.stub(:class).and_return(TakaTicTacToe::Human)
      game.ui.stub(:ask_move).and_return("3")
      game.set_slots('XX3456789')
      game.make_player_moves
    end

    it "prints the board twice if both players are human" do
      game.ui.should_receive(:print_board).twice
      game.player_two.stub(:class).and_return(TakaTicTacToe::Human)
      game.make_player_moves
      ui.asked_move.should be_true
    end

    it "prints out the board" do
      game.ui.should_receive(:print_board)
      game.make_player_moves
    end
  end

  describe "find_move" do
    it "makes a human move" do
      game.player_one.stub(:class).and_return(TakaTicTacToe::Human)
      game.ui.should_receive(:ask_move).and_return("1")
      game.find_move(game.player_one).should == "1"
    end

    it "makes a computer move" do
      game.player_one.stub(:class).and_return(TakaTicTacToe::Computer)
      game.player_one.should_receive(:make_move).with(game.board).and_return("2")
      game.find_move(game.player_one).should == "2"
    end
  end
end
