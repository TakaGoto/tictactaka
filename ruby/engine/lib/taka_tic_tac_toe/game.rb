module TakaTicTacToe
  class Game

    attr_reader :ui, :board, :player_one, :player_two
    attr_accessor :over

    def initialize(ui, settings={}, over = false)
      @ui = ui
      game_settings(settings) if !settings.empty?
      @over = over
    end

    def game_settings(settings)
      @player_one = PlayerFactory.create(:type => settings[:player_one].to_sym, :mark => "X")
      @player_two = PlayerFactory.create(:type => settings[:player_two].to_sym, :mark => "O")
      @board = Board.new
      @board.board_size(settings[:board].to_i)
    end

    def self.play_game(ui, settings, move="")
      game = self.new(ui, settings)
      game.set_slots(settings[:game_board])
      player = game.find_player(settings[:game_board])

      if game.board.is_empty? && player.class != Computer
        game.ui.display_message
        game.ui.print_board(game.board)
        game.set_move(player.mark, move)
      elsif game.is_over?
        game.ui.display_result(game.result)
        game.over = true
      else
        game.ui.ask_move(player)
        move = game.find_move(player) if player.class == Computer
        game.set_move(player.mark, move)
        game.ui.print_board(game.board)

        if game.is_over?
          game.ui.display_result(game.result)
          game.over = true
       end
      end

      game
    end

    def find_player(board)
      count = 0
      (0..board.length-1).each do |index|
        count += 1 if board[index] != '_'
      end

      if count.even? || count.zero?
        return @player_one
      else
        return @player_two
      end
    end

    def ask_player_one_type
      @player_one = PlayerFactory.create(:type => @ui.ask_player_one_type, :mark => "X")
    end

    def ask_player_two_type
      @player_two = PlayerFactory.create(:type => @ui.ask_player_two_type, :mark => "O")
    end

    def board_option
      @board = Board.new
      @board.board_size(@ui.ask_board_option)
    end

    def ask_options
      board_option
      ask_player_one_type
      ask_player_two_type
    end

    def start_game
      @ui.display_message
      ask_options
      @ui.print_board(@board)
    end

    def end_game
      @ui.print_board(@board)
      @ui.display_result(result)
      @board.reset
      continue?
    end

    def start
      start_game

      make_player_moves until is_over?

      end_game
    end

    def find_move(player)
      return @ui.ask_move(player) if player.class == Human
      return player.make_move(@board)
    end

    def ask_move(player)
      user_input = @ui.ask_move(player)
      while 0 > user_input || user_input > (@board.length**2 - 1)
        @ui.output.puts("incorrect move, please try again")
        user_input = @ui.ask_move(player)
      end
      user_input
    end

    def make_player_moves(moves={})
      moves[:player_one] = find_move(@player_one)

      if valid?(moves[:player_one])
        set_move(@player_one.mark, moves[:player_one])

        if !is_over?
          @ui.print_board(@board) if @player_two.class == Human
          moves[:player_two] = find_move(@player_two)
          set_move(@player_two.mark, moves[:player_two])
          @ui.print_board(@board)
        end
      end
    end

    def set_move(mark, move)
      @board.set_move(mark, move) if !move.empty? && valid?(move)
    end

    def continue?
      start if @ui.continue?
      @over = true
    end

    def has_winner
      has_winner = false
      @board.win_comb.each {|comb| has_winner = true if unique?(comb)}
      has_winner
    end

    def winner
      winner = ""
      @board.win_comb.each {|comb| winner = @board.slots[comb[0]-1] if unique?(comb)}
      winner
    end

    def is_tie
      @board.full? && !@board.has_winner
    end

    def is_over?
      is_tie || has_winner
    end

    def valid?(index)
      !@board.is_filled(index)
    end

    def result
      return "tie" if is_tie
      winner
    end

    def set_slots(board)
      @board = Board.parse(board)
    end

    def unique?(nums)
      nums.map {|n| @board.slots[n-1]}.uniq.length == 1
    end
  end
end
