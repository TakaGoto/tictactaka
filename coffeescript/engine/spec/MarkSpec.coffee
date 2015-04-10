describe 'Mark', ->
  it 'has a character', ->
    mark = new Mark("X")
    expect(mark.toString()).toBe("X")
