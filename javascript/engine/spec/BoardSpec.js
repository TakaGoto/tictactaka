describe("Board", function() {
  var board;

  it("supports 3x3 board", function() {
    board = new Board(3);

    expect(board.slots.length).toEqual(9);
  });

  it("supports 4x4 board", function() {
    board = new Board(4);

    expect(board.slots.length).toEqual(16);
  });

  it("makes a move onto the board", function() {
    board = new Board(3);
    board.makeMove(1, 'X');

    expect(board.getSlot(1)).toEqual('X');
  });
});
