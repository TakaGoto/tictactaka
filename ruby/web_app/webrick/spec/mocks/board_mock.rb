class BoardMock
  attr_reader :print_slots

  def slots
    @printed_slots = true
  end
end
