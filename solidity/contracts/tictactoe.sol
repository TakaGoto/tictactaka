pragma solidity ^0.5.8;

contract TicTacToe {
    mapping(address => string) games;
    byte constant X_MARK = "X";
    byte constant O_MARK = "O";
    string board;

    function setBoard(string memory newBoard) public {
      board = newBoard;
    }

    function getBoard() public view returns (string memory) {
      return board;
    }

    function getGame(address ownerAddress) public view returns (string memory) {
      return games[ownerAddress];
    }

    function makeMove(uint move) public {
      bytes memory tempBoard = bytes(board);
      int xCount = 0;
      int oCount = 0;
      byte marker;

      for (uint i = 0; i < tempBoard.length; i++) {
        byte square = tempBoard[i];
        if (square == X_MARK)
          xCount++;
        else if (square == O_MARK)
          oCount++;
      }

      xCount == oCount ? marker = X_MARK : marker = O_MARK;
      tempBoard[move] = marker;
      board = string(tempBoard);
    }

    function startGame() public {
      games[msg.sender] = "blah";
    }

    function undoMove(uint move) public {
      bytes memory tempBoard = bytes(board);
      // bytes memory byteMove = toBytes(move);
      tempBoard[move] = byte(uint(move / (2**(8*(32)))));
      board = string(tempBoard);
    }

    function toBytes(uint256 x) private returns (bytes memory b) {
      b = new bytes(32);
      for (uint i = 0; i < 32; i++) {
        b[i] = byte(uint8(x / (2**(8*(31 - i)))));
    }
    }
}
