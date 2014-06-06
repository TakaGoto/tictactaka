function Board(boardSize) {
  this.slots = new Array(boardSize * boardSize)

  this.makeMove = function(slot, mark) {
    this.slots[0] = mark
  }

  this.getSlot = function(slot) {
    return this.slots[0]
  }
}
