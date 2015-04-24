describe 'TicTacToe', ->
  it 'is game over if there is a winner', ->
    board = "xxx______"

    game = TicTacToe.play(board: board)

    expect(game.isOver()).toBe(true)

  it 'is not game over if there is no winner', ->
    board = "_________"

    game = TicTacToe.play(board: board)

    expect(game.isOver()).toBe(false)

  it 'makes a move for first player', ->
    setup =
      board: "_________"
      emptySpace: "_"
      playerOne:
        mark: "x"
        type: "1"
      playerTwo:
        mark: "o"
        type: "1"
      nextMove: "1"

    game = TicTacToe.makeMove(setup)

    expect(game.board.toString()).toBe("x________")

