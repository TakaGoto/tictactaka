describe 'TicTacToe', ->
  it 'is game over if there is a winner', ->
    setup =
      board: "xxx______"
      emptySpace: "_"
      playerOne:
        mark: "x"
        type: "1"
      playerTwo:
        mark: "o"
        type: "1"

    game = TicTacToe.play(setup)

    expect(game.isOver()).toBe(true)

  it 'is game over if O won', ->
    setup =
      board: "ooo______"
      emptySpace: "_"
      playerOne:
        mark: "x"
        type: "1"
      playerTwo:
        mark: "o"
        type: "1"

    game = TicTacToe.play(setup)

    expect(game.isOver()).toBe(true)

  it 'is not game over if there is no winner', ->
    setup =
      board: "_________"
      emptySpace: "_"
      playerOne:
        mark: "x"
        type: "1"
      playerTwo:
        mark: "o"
        type: "1"

    game = TicTacToe.play(setup)

    expect(game.isOver()).toBe(false)

  it 'is game over if there is a tie', ->
    setup =
      board: "xoxxoxoxo"
      emptySpace: "_"
      playerOne:
        mark: "x"
        type: "1"
      playerTwo:
        mark: "o"
        type: "1"

    game = TicTacToe.play(setup)

    expect(game.isOver()).toBe(true)

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

