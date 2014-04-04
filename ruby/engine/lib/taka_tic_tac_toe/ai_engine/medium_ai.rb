module TakaTicTacToe
  module AiEngine
    class MediumAi
      Negative_Infinity = -1.0/0

      def self.make_move(board, mark, num = random_num)
        if num == 0
          TakaTicTacToe::AiEngine::EasyAi.make_move(board, mark)
        else
          TakaTicTacToe::AiEngine::ImpossibleAi.make_move(board, mark)
        end
      end

      def self.random_num
        Random.rand(2)
      end
    end
  end
end
