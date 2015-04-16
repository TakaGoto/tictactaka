describe 'Board', ->

  it 'creates a board by string', ->
    board = Board.fromString("x________")

    expect(board.slots[0]).toBe("x")
    expect(board.slots[1]).toBe("_")

  it 'creates a 3x3 board', ->
    board = new Board(3)

    expect(board.slots.length).toBe(9)

  it 'creates a 4x4 board', ->
    board = new Board(4)

    expect(board.slots.length).toBe(16)

  it 'places a mark in a slot', ->
    board = new Board(3)

    board.placeMark(1, "x")

    expect(board.slots[0]).toBe("x")

  it 'returns the horizontal combinations for a 3x3', ->
    expectedCombinations = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
    board = new Board(3)

    combinations = board.horizontalCombinations()

    expect(combinations).toEqual(expectedCombinations)
