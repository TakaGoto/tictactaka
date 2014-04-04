module TakaTicTacToe
  module AiEngine
    class Factory
      def self.get(move)
        case move[:difficulty]
        when :easy_ai
          EasyAi.make_move(move[:board], move[:mark])
        when :impossible_ai
          ImpossibleAi.make_move(move[:board], move[:mark])
        when :medium_ai
          MediumAi.make_move(move[:board], move[:mark])
        end
      end
    end
  end
end
