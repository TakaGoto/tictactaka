class BoardMock
  attr_reader :printed_board, :slots, :changed_to_blanks

  def print_slots
    @printed_board = true
  end

  def slots
    @slots = true
  end

  def to_blanks
    @changed_to_blanks = true
    '_________'
  end
end
