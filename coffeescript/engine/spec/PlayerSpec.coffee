describe 'Player', ->
  it 'has a mark', ->
    player = new Player(mark: "x")

    expect(player.mark.char).toBe("x")
