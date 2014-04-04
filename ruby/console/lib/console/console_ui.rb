module Console
  class UI
    def self.output
      @output ||= $stdout
    end

    def self.input
      @input ||= $stdin
    end

    def self.ask_player_one_type
      output.puts "Enter Player One Type ((H)uman/(C)omputer):"
      user_input = self.return_player_type(input.gets.chomp)
      while user_input == :error
        output.puts "Please enter the right type for player one ((H)uman/(C)omputer):"
        user_input = self.return_player_type(input.gets.chomp)
      end

      user_input
    end

    def self.ask_player_two_type
      output.puts "Enter Player Two Type ((H)uman/(C)omputer):"
      user_input = self.return_player_type(input.gets.chomp)

      while user_input == :error
        output.puts "Please enter the right type for player two ((H)uman/(C)omputer):"
        user_input = self.return_player_type(input.gets.chomp)
      end

      user_input
    end

    def self.return_player_type(type)
      if type.downcase == "h"
        return :human
      elsif type.downcase == 'c'
        return :computer
      else
        return :error
      end
    end

    def self.ask_board_option
      output.puts "Enter board size(3 or 4)"
      user_input = self.get_input
      until user_input == 3 || user_input == 4
        output.puts "Please enter the right board size (3 or 4)"
        user_input = self.get_input
      end

      user_input
    end

    def self.display_result(result)
      output.puts "It is a tie!" if result == "tie"
      output.puts "#{result} has won!" if result != "tie"
    end

    def self.display_message
      output.puts "Welcome to Tic Tac Toe!"
    end

    def self.finished
      output.puts "End of game, good bye!"
    end

    def self.continue?
      output.puts "Play again? y/n"
      user_input = (self.input.gets.chomp).upcase
      while user_input != 'Y' && user_input != 'N'
        output.puts "Play again? y/n"
        user_input = (self.input.gets.chomp).upcase
      end

      user_input == 'Y'
    end

    def self.ask_move(player)
      turn_player = player.mark == 'X' ? "player one" : "player two"
      output.puts "Enter your move #{turn_player}: "
      user_input = self.get_input.to_s
    end

    def self.get_input
      input.gets.chomp.to_i
    end

    def self.print_board(board)
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

    def self.error
      output.puts "There was an error"
    end
  end
end
