module TakaTicTacToe
  class Computer
    attr_reader :mark
    attr_accessor :difficulty

    def initialize(mark, difficulty = :impossible_ai)
      @mark = mark
      @difficulty = difficulty
    end

    def make_move(board)
      move = {:difficulty => @difficulty,
              :board => board,
              :mark => @mark}

      AiEngine::Factory.get(move)
    end
  end
end


