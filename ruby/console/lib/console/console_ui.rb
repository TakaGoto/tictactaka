module Console
  class UI
    class << self
      def output
        @output ||= $stdout
      end

      def input
        @input ||= $stdin
      end

      def ask_player_one_type
        output.puts "Enter Player One Type ((H)uman/(C)omputer):"
        user_input = return_player_type(input.gets.chomp)
        while user_input == :error
          output.puts "Please enter the right type for player one ((H)uman/(C)omputer):"
          user_input = return_player_type(input.gets.chomp)
        end

        user_input
      end

      def ask_player_two_type
        output.puts "Enter Player Two Type ((H)uman/(C)omputer):"
        user_input = return_player_type(input.gets.chomp)

        while user_input == :error
          output.puts "Please enter the right type for player two ((H)uman/(C)omputer):"
          user_input = return_player_type(input.gets.chomp)
        end

        user_input
      end

      def return_player_type(type)
        if type.downcase == "h"
          return :human
        elsif type.downcase == 'c'
          return :computer
        else
          return :error
        end
      end

      def ask_board_option
        output.puts "Enter board size(3 or 4)"
        user_input = get_input
        until user_input == 3 || user_input == 4
          output.puts "Please enter the right board size (3 or 4)"
          user_input = get_input
        end

        user_input
      end

      def display_result(result)
        output.puts "It is a tie!" if result == "tie"
        output.puts "#{result} has won!" if result != "tie"
      end

      def display_message
        output.puts "Welcome to Tic Tac Toe!"
      end

      def finished
        output.puts "End of game, good bye!"
      end

      def continue?
        output.puts "Play again? y/n"
        user_input = (input.gets.chomp).upcase
        while user_input != 'Y' && user_input != 'N'
          output.puts "Play again? y/n"
          user_input = (input.gets.chomp).upcase
        end

        user_input == 'Y'
      end

      def ask_move(player)
        turn_player = player.mark == 'X' ? "player one" : "player two"
        output.puts "Enter your move #{turn_player}: "
        user_input = get_input.to_s
      end

      def get_input
        input.gets.chomp.to_i
      end

      def print_board(board)
        output_board = ""
        board.slots.each_index do |slot|
          num = board.slots[slot]
          if num.length > 1
            output_board += "|  #{num} "
          else
            output_board += "|  #{num}  "
          end
          output_board += "|\n" if ((slot+1) % board.length).zero?
        end
        output.puts output_board + "\n\n"
      end

      def error
        output.puts "There was an error"
      end
    end
  end
end

