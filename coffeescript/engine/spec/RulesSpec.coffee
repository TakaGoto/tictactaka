describe 'Rules', ->
  it 'returns true if the game is over', ->
    expect(Rules.isOver("xxx______", "x")).toBe(true)

  it 'returns false if the game is not over', ->
    expect(Rules.isOver("_________", "x")).toBe(false)
