require 'spec_helper'

describe TakaTicTacToe::Board do
  let(:board) {described_class.new}

  describe "#new" do
    it "should create an array with numbers" do
      (1..9).each do |num|
        board.get(num).should eq("#{num}")
      end
    end
  end

  describe "#to_blanks" do
    it "replaces numbers with underscores" do
      board.to_blanks.should == '_________'
    end

    it "replaces 16 board with underscores" do
      board.board_size(4)
      board.to_blanks.should == '________________'
    end

    it "does not replace slot with underscore" do
      board.board_size(4)
      board.slots[0] = "X"
      board.to_blanks.should == 'X_______________'
    end
  end

  describe "making moves" do
    describe "#set_move" do
      it "should put 'X' on position 1" do
        board.set_move('X', 1)
        board.get(1).should eq('X')
      end

      it "should allow multiple inputs from some player" do
        board.set_move('X', 1, 2, 4)
        board.get(1).should eq('X')
        board.get(2).should eq('X')
        board.get(4).should eq('X')
      end
    end

    describe "#undo_move" do
      it "should undo the move" do
        board.set_move('X', 1)
        board.undo_move(1)
        board.get(1).should == '1'
      end
    end
  end

  describe "#is_filled" do
    it "should is true when the slot is filled" do
      board.set_move('X', 4)
      board.is_filled(4).should be_true
    end
  end

  describe "checking the board" do
    before(:each) do
      board.set_move('X', 5, 2, 4, 7, 9)
      board.set_move('O', 1, 8, 6, 3)
    end
    describe "#is_tie" do
      it "should check if the board is a tie" do
        board.is_tie.should be_true
      end
    end
  end

    describe "#full?" do
      it "should return true if the board is full for 4x4" do
        board.board_size(4)
        board.set_move('X', 1, 2, 3, 4, 5, 6, 7, 8)
        board.set_move('O', 9, 10, 11, 12, 13, 14, 15, 16)
        board.full?.should be_true
      end
    end

    describe "#unique?" do
      it "should return false when there is no winner and slots are full" do
        board.unique?([2,4,6]).should be_false
      end
    end

    describe "#has_winner" do
      it "should return false when all slots are filled but no winner" do
        board.has_winner.should be_false
      end
    end

    describe "#empty_slots" do
      it "should return all the current empty slots" do
        board.empty_slots.should == ["1","2","3","4","5","6","7","8","9"]
      end
    end

    describe "winner" do
      [[1,2,3],[1,4,7],[3,5,7]].each do |num1, num2, num3, line|
        it "should return 'X' with slots #{num1}#{num2}#{num3}" do
          board.set_move('X', num1, num2, num3)
          board.winner.should == 'X'
        end
      end
    end

    describe "#is_empty?" do
      it "should say the board is empty" do
        board.is_empty?.should be_true
      end

      it "should be not be empty with marks" do
        board = described_class.parse('1234X6789')
        board.is_empty?.should be_false
      end
    end

  describe "retrieves/parses a board" do
    it "parses board" do
      board_string = '123XO6789'
      board = described_class.parse(board_string)
      board_string.split('').each_with_index do |mark, i|
        board.get(i+1).should == mark
      end
      board.slots.should be_a(Array)
    end

    it 'retrieves a board' do
      board_string = '123XO6789'
      board = described_class.parse(board_string)
      board.to_s.should == board_string
    end

    it 'retrieves a 4x4 board with length 4' do
      board_string = '________________'
      board = described_class.parse(board_string)
      board.length.should == 4
    end

    it "retrieves a length 4 for the board" do
      board_string = '12345678X10111213141516'
      board = described_class.parse(board_string)
      board.length.should == 4
    end

    it "retrievs a board with underscore" do
      board_string = '_________'
      board = described_class.parse(board_string)
      board.to_s.should == '123456789'
    end

    it "retrievs a board with underscore with marsk" do
      board_string = 'X________'
      board = described_class.parse(board_string)
      board.to_s.should == 'X23456789'
    end
  end

  describe "four by four board" do
    it "creates a four by four board" do
      big_board = described_class.new
      big_board.board_size(4)
      big_board.slots.should == ["1", "2", "3", "4",
                           "5", "6", "7", "8",
                           "9", "10", "11", "12",
                           "13", "14", "15", "16"]
      big_board.length.should == 4
    end

    it "still creates a three by three board" do
      small_board = described_class.new
      small_board.board_size(3)
      small_board.slots.should == ["1", "2", "3",
                                   "4", "5", "6",
                                   "7", "8", "9"]
      small_board.length.should == 3
    end
  end

  describe "#generate_win_comb" do
    it "generates winning combination for 3x3" do
      board.generate_win_comb
      board.win_comb.should == [[1,2,3],[4,5,6],[7,8,9],
                              [1,4,7],[2,5,8],[3,6,9],
                              [1,5,9],[3,5,7]]
    end

    it "generates winning combination for 4x4" do
      board.board_size(4)
      board.generate_win_comb
      board.win_comb.should == [[1, 2, 3, 4]   , [5, 6, 7, 8],
                               [9, 10, 11, 12], [13, 14, 15, 16],
                               [1, 5, 9, 13]  , [2, 6, 10, 14],
                               [3, 7, 11, 15] , [4, 8, 12, 16],
                               [1, 6, 11, 16] , [4, 7, 10, 13]]
    end
  end
end
