describe 'Player', ->
  it 'has a mark', ->
    player = new Player(mark: "x")

    expect(player.mark.char).toBe("x")

  it 'has a type', ->
    player = new Player(type: "1")

    expect(player.type).toBe("human")
