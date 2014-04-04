require 'spec_helper'

describe Console::UI do
  let(:console) {described_class}

  {
    "display_message" => "Welcome to Tic Tac Toe!",
    "finished" => "End of game, good bye!",
    "error" => "There was an error",
  }.each do |method, output|
    it "should output #{output}" do
      console.input.stub(:gets).and_return("1")
      console.output.should_receive(:puts).with(output)
      console.send(method)
    end
  end

  describe 'check_continue_input' do
    it 'returns true if user input is y' do
      console.output.stub(:puts)
      console.input.stub(:gets).and_return('y')
      console.continue?.should be_true
    end

    it 'returns false if user input is n' do
      console.output.stub(:puts)
      console.input.stub(:gets).and_return('n')
      console.continue?.should be_false
    end

    it 'asks to play again, again if user input is not n/y' do
      console.output.stub(:puts)
      console.input.stub(:gets).and_return('u', 'y')
      console.continue?.should be_true
    end
 end

  it "should output 'Enter board size(3 or 4)'" do
    console.input.stub(:gets).and_return("4")
    console.output.should_receive(:puts).with('Enter board size(3 or 4)')
    console.ask_board_option
  end

  describe "#ask_move" do
    it "asks move" do
      console.output.should_receive(:puts)
      player = TakaTicTacToe::Human.new("X")
      STDIN.stub(:gets).and_return("C")
      console.ask_move(player)
    end
  end

  it "displays a tie" do
    console.output.should_receive(:puts).with("It is a tie!")
    console.display_result("tie")
  end

  it "displays a winner" do
    console.output.should_receive(:puts).with("X has won!")
    console.display_result("X")
  end

  it "takes in a players input" do
    console.input.stub(:gets).and_return("1")
    console.get_input.should == 1
  end

  it "takes in a board size" do
    console.input.stub(:gets).and_return("4")
    console.get_input.should == 4
  end

  it "prints the board" do
    console.output.should_receive(:puts)
    outstream = StringIO.new
    board = TakaTicTacToe::Board.new
    console.print_board(board)
    outstream.string.should == ""
  end

  describe "#ask_player_one_type" do
    it 'should ask for player type when input is wrong' do
      console.output.should_receive(:puts).twice
      console.input.should_receive(:gets).and_return("U", "C")
      result = console.ask_player_one_type
      result.should == :computer
   end

    it "should output 'Enter Player One Type ((H)uman/(C)omputer):'" do
      console.output.should_receive(:puts)
      console.input.should_receive(:gets).and_return("C")
      console.should_receive(:return_player_type).with("C").and_return(:computer)
      result = console.ask_player_one_type
      result.should == :computer
    end

    it "takes in 'H'" do
      console.input.should_receive(:gets).and_return("H")
      console.should_receive(:return_player_type).with("H").and_return(:human)
      console.output.should_receive(:puts)
      console.ask_player_one_type.should == :human
    end
  end

  describe "#ask_player_two_type" do
    it 'should ask for player type when input is wrong' do
      console.output.should_receive(:puts).twice
      console.input.should_receive(:gets).and_return("U", "H")
      console.ask_player_one_type.should == :human
    end

    it "should output 'Enter Player Two Type ((H)uman/(C)omputer):'" do
      console.output.should_receive(:puts)
      console.input.should_receive(:gets).and_return("C")
      console.should_receive(:return_player_type).with("C").and_return(:computer)
      console.ask_player_two_type.should == :computer
    end

    it "takes in 'H'" do
      console.output.should_receive(:puts)
      console.input.should_receive(:gets).and_return("H")
      console.should_receive(:return_player_type).with("H").and_return(:computer)
      console.ask_player_two_type.should == :computer
    end
  end

  describe "#return_player_type" do
    it "returns the human player type" do
      console.return_player_type("H").should == :human
    end

    it "returns the computer player type" do
      console.return_player_type("C").should == :computer
    end
  end
end
