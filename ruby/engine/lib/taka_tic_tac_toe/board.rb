module TakaTicTacToe
  class Board
    attr_accessor :slots, :length
    attr_reader :width, :win_comb

    def initialize
      @slots = %w[1 2 3 4 5 6 7 8 9]
      @length = 3
      generate_win_comb
    end

    def board_size(length)
      @length = length
      @slots = (1..(length**2)).reduce([]) {|slots, n| slots.push(n.to_s)}
      generate_win_comb
    end

    def to_s
      @slots.join
    end

    def to_blanks
      blanks = @slots.reduce("") do |blanks, slots|
        if !slots.to_i.zero?
          blanks << '_'
        else
          blanks << slots
        end
      end
    end

    def self.parse(board)
      parsed_board = self.new
      parsed_board.board_size(4) if board.length > 9
      parse_board = []
      temp_board = board.split('')
      temp_board.each_index do |slot|
        if temp_board[slot] == '_' || temp_board[slot].to_i != 0
          parse_board << (slot + 1).to_s
        else
          parse_board << temp_board[slot]
        end
      end
      parsed_board.slots = parse_board
      parsed_board
    end

    def get(index)
      @slots[index-1]
    end

    def full?
     (@slots.count {|x| x == 'X'} + @slots.count {|x| x == 'O'}) == (@length**2)
    end

    def is_empty?
      !@slots.include?("X") && !@slots.include?("O")
    end

    def empty_slots
      @slots.select {|x| x.to_i != 0}
    end

    def is_filled(index)
      @slots[(index.to_i) - 1].to_i == 0
    end

    def set_move(mark, *index)
      index.each do |index|
        @slots[(index.to_i)-1] = mark
      end
    end

    def is_tie
      full? && !has_winner
    end

    def reset
      board_size(@length)
    end

    def print_slots
     @slots.each_slice(@length) {|line| p line}
    end

    def has_winner
      has_winner = false
      @win_comb.each {|comb| has_winner = true if unique?(comb)}
      has_winner
    end

    def winner
      winner = ""
      @win_comb.each {|comb| winner = @slots[comb[0]-1] if unique?(comb)}
      winner
    end

    def unique?(nums)
      nums.map {|n| @slots[n-1]}.uniq.length == 1
    end

    def undo_move(index)
      @slots[(index.to_i)-1] = index.to_s
    end

    def generate_win_comb
      @win_comb = []
      horizontal_wins
      vertical_wins
      diagonal_wins
    end

    def horizontal_wins
      (@slots.map {|num| num.to_i}).each_slice(@length) {|nums| @win_comb.push(nums)}
    end

    def vertical_wins
      @length.times do |start|
        ((start+1)..(@length**2)).step(@length).each_slice(@length) do |nums|
          @win_comb.push(nums)
        end
      end
    end

    def diagonal_wins
      (1..(@length**2)).step(@length+1).each_slice(@length) do |nums|
        @win_comb.push(nums)
      end
      ((@length)..(@length**2)- 1).step(@length-1).each_slice(@length) do |nums|
        @win_comb.push(nums)
      end
    end

  end
end
