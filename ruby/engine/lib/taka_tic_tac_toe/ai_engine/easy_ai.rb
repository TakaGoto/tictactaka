module TakaTicTacToe
  module AiEngine
    class EasyAi
      def self.make_move(board, mark)
        board.empty_slots.first
      end
    end
  end
end
