describe("Player", function() {
  var player;
  var ui = new MockUi();

  it("has a mark, a ui, and player type", function() {
    player = new Player("X", "human", ui);

    expect(player.mark).toEqual("X");
    expect(player.type).toEqual("human");
    expect(player.ui).toEqual(ui);
  });
});
