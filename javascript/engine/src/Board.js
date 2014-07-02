function Board(boardSize) {
  this.slots = new Array(boardSize * boardSize);
  this.boardSize = boardSize;

  this.makeMove = function(slot, mark) {
    this.slots[slot] = mark
  }

  this.getSlot = function(slot) {
    return this.slots[slot]
  }
}
