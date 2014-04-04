module TakaTicTacToe
  module AiEngine
    class ImpossibleAi
      Infinity = 1.0/0
      Negative_Infinity = -1.0/0

      def self.make_move(board, mark)
        best_score = Negative_Infinity
        best_index = 0
        opponent_mark = mark == 'X' ? 'O' : 'X'

        board.empty_slots.each do |slot|
          board.set_move(mark, slot)
          score = alpha_beta(board, opponent_mark, 0, Negative_Infinity, Infinity, false, -1)
          board.undo_move(slot)

          if score > best_score
            best_score = score
            best_index = slot
          end
        end
        return best_index
      end

      def self.alpha_beta(board, mark, depth, alpha, beta, max_player, color)
        opponent_mark = mark == 'X' ? 'O' : 'X'

        return check_game_state(board, mark, depth) * color if game_finished(board, depth)

        if max_player
          board.empty_slots.each do |slots|

            board.set_move(mark, slots)
            alpha = [alpha, alpha_beta(board, opponent_mark, depth+1, alpha, beta, not(max_player), -color)].max
            board.undo_move(slots)
            break if alpha >= beta
          end
          return alpha
        else

          board.empty_slots.each do |slots|

            board.set_move(mark, slots)
            beta = [beta, alpha_beta(board, opponent_mark, depth+1, alpha, beta, not(max_player), -color)].min
            board.undo_move(slots)
            break if alpha >= beta
          end
          return beta
        end
      end

      def self.check_game_state(board, mark, depth)
        return 0 if board.is_tie
        return 10 + depth if board.winner == mark
        -10 + depth
      end

      def self.game_finished(board, depth)
        board.has_winner || board.is_tie || depth == 6
      end
    end
  end
end
