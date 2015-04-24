describe 'Board', ->

  it 'creates a board by string', ->
    board = Board.fromString("x________")

    expect(board.slots[0]).toBe("x")
    expect(board.slots[1]).toBe("_")

  it 'creates a 3x3 board', ->
    board = new Board(size: 3, emptySpace: "_")

    expect(board.slots.length).toBe(9)

  it 'creates a 4x4 board', ->
    board = new Board(size: 4, emptySpace: "_")

    expect(board.slots.length).toBe(16)

  it 'places a mark in a slot', ->
    board = new Board(size: 3, emptySpace: "_")

    board.placeMark(1, "x")

    expect(board.slots[0]).toBe("x")

  it 'returns the horizontal slots for a 3x3', ->
    expectedSlots = [
      [1, 2, 3]
      [4, 5, 6]
      [7, 8, 9]
    ]
    board = new Board(size: 3, emptySpace: "_")

    slots = board.horizontalSlots()

    expect(slots).toEqual(expectedSlots)

  it 'returns the vertical slots for a 3x3', ->
    expectedSlots = [
      [1, 4, 7]
      [2, 5, 8]
      [3, 6, 9]
    ]
    board = new Board(size: 3, emptySpace: "_")

    slots = board.verticalSlots()

    expect(slots).toEqual(expectedSlots)

  it 'returns the diagonal slots for a 3x3', ->
    expectedSlots = [
      [1, 5, 9]
      [3, 5, 7]
    ]
    board = new Board(size: 3, emptySpace: "_")

    slots = board.diagonalSlots()

    expect(slots).toEqual(expectedSlots)

  it 'returns the mark for a slot', ->
    board = new Board(size: 3, emptySpace: "_")

    board.placeMark(1, "x")

    expect(board.getSlot(1)).toEqual("x")

  it 'returns multiple marks', ->
    board = new Board(size: 3, emptySpace: "_")

    board.placeMark(1, "x")
    board.placeMark(2, "x")

    expect(board.getSlots([1, 2, 3])).toEqual(["x", "x", "_"])

  it 'returns string representation of board', ->
    board = new Board(size: 3, emptySpace: "_")

    board.placeMark(1, "x")
    board.placeMark(2, "x")

    expect(board.toString()).toEqual("xx_______")

  it 'returns the number of empty spaces', ->
    board = new Board(size: 3, emptySpace: "_", marks: ["x", "o"])

    board.placeMark(1, "x")

    expect(board.emptySpaces()).toEqual(8)
