require 'spec_helper'

describe TakaTicTacToe::Computer do
  let(:computer) {described_class.new('O')}

  describe "#difficulty" do
    it "sets the computer to Impossible Ai" do
      computer.difficulty = :impossible_ai
      computer.difficulty.should == :impossible_ai
    end

    it "sets the computer to Medium Ai" do
      computer.difficulty = :medium_ai
      computer.difficulty.should == :medium_ai
    end

    it "sets the computer to Easy Ai" do
      computer.difficulty = :easy_ai
      computer.difficulty.should == :easy_ai
    end
 end

  describe "#make_move" do
    it "makes a move" do
      board = game_board.new
      computer.difficulty = :easy_ai
      computer.make_move(board).should == "1"
    end
  end
end
