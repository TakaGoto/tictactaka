module TakaTicTacToe
  class Human
    attr_reader :mark

    def initialize(mark)
      @mark = mark
    end

    def make_move(index, board)
      board.set_move(@mark, index)
    end
  end
end
