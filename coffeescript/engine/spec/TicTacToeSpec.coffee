describe 'TicTacToe', ->
  it 'is game over if there is a winner', ->
    board = "xxx______"

    game = TicTacToe.play(board: board)

    expect(game.isOver()).toBe(true)

  xit 'is not game over if there is no winner', =>
    board = "_________"

    game = TicTacToe.play(board: board)

    expect(game.isOver()).toBe(false)
