module TakaTicTacToe
  class PlayerFactory
    def self.create(input)
      case input[:type]
      when :computer
        Computer.new(input[:mark])
      when :human
        Human.new(input[:mark])
      else
        raise "unknown player type"
      end
    end
  end
end
