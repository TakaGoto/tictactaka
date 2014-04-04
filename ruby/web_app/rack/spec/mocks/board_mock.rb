class BoardMock
  attr_reader :printed_slots, :called_to_blanks

  def slots
    @printed_slots = true
  end

  def to_blanks
    @called_to_blanks = true
    '_________'
  end
end
