require 'spec_helper'

describe TakaTicTacToe::AiEngine::ImpossibleAi do
  let(:board) {game_board.new}
  let(:mark) {'O'}

  describe "#alpha_beta" do
    context "when impossible ai face eachother", :slow_tests => true do
      1.times do
        it "ends in a tie" do
          computer1 = TakaTicTacToe::Computer.new('X')
          computer1.difficulty = :impossible_ai
          computer2 = TakaTicTacToe::Computer.new('O')
          computer2.difficulty = :impossible_ai
          board = create_board('123456789')

          board.set_move(computer1.mark, computer1.make_move(board))
          board.set_move(computer2.mark, computer2.make_move(board))

          board.set_move(computer1.mark, computer1.make_move(board))
          board.set_move(computer2.mark, computer2.make_move(board))

          board.set_move(computer1.mark, computer1.make_move(board))
          board.set_move(computer2.mark, computer2.make_move(board))

          board.set_move(computer1.mark, computer1.make_move(board))
          board.set_move(computer2.mark, computer2.make_move(board))

          board.set_move(computer1.mark, computer1.make_move(board))
          board.set_move(computer2.mark, computer2.make_move(board))

          board.is_tie.should be_true
        end
      end
    end

    context "should return a winning move" do
      it "returns slot 3 to win the game" do
        board = create_board('OO34X6X8X')
        described_class.make_move(board, mark).should == "3"
      end

      it "makes a winning move instead of a tie" do
        board = create_board('XOX45O7OX')
        described_class.make_move(board, mark).should == "5"
      end

      it "makes an early winning move" do
        board = create_board('OX34O6XX9')
        described_class.make_move(board, mark).should == "9"
      end
    end

    context "should threat a win" do
      it "returns slot 3" do
        board = create_board('O234X678X')
        described_class.make_move(board, mark).should == "3"
      end
    end

    context "should return a blocking move" do
      it "returns slot 7 so that game is a tie and not a loss" do
        board = create_board('OXXXXO7O9')
        described_class.make_move(board, mark).should == "7"
      end

      describe "optimization" do
        it "returns first move under 10 seconds", :slow_tests => true do
          board = create_board('123456789')
          time = Time.now
          described_class.make_move(board, mark)
          time2 = Time.now
          (time2 - time).should < 10
        end
      end
    end

    it "should not pick '2' after '1'", :slow_tests => true do
      board = create_board('X23456789')
      described_class.make_move(board, mark).should_not == '2'
    end
  end

  describe "#minimax" do
    let(:depth) {0}
    let(:alpha) {-1.0/0}
    let(:beta) {1.0/0}

    it "returns 10 on a winning board" do
      board = create_board('OOO456789')
      described_class.alpha_beta(board, mark, depth, alpha, beta, false, 1).should == 10
    end

    it "returns -10 on a losing board" do
      board = create_board('XXX456789')
      described_class.alpha_beta(board, mark, depth, alpha, beta, false, 1).should == -10
    end

    it "returns 0 on a tie" do
      board = create_board('XOXXOXOXO')
      described_class.alpha_beta(board, mark, depth, alpha, beta, false, 1).should == 0
    end

    it "returns 10 a move behind" do
      board = create_board('OO3456789')
      described_class.alpha_beta(board, mark, depth, alpha, beta, false, -1).should == -9
    end

    it "returns a 0 a move behind" do
      board = create_board('OXOOXOX8X')
      described_class.alpha_beta(board, mark, depth, alpha, beta, false, -1).should == 0
    end

    it "returns a -10 a move behind" do
      board = create_board('XXXXXXXX9')
      described_class.alpha_beta(board, mark, depth, alpha, beta, false, 1).should == -10
    end

    it "returns 10 two moves behind" do
      board = create_board('O2OOXXXX9')
      described_class.alpha_beta(board, mark, depth, alpha, beta, false, -1).should == -9
    end
  end

  it "return '4' on a 4x4 board", :slow_tests => true do
     board = TakaTicTacToe::Board.new
     board.board_size(4)
     board.set_move("X", 1, 2, 3)
     described_class.make_move(board, mark).should == "4"
  end

  it "return a winnin move on a 4x4 board", :slow_tests => true do
     board = TakaTicTacToe::Board.new
     board.board_size(4)
     board.set_move("O", 1, 2, 3)
     described_class.make_move(board, mark).should == "4"
  end
end

