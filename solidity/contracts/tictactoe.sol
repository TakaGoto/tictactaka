pragma solidity ^0.4.19;

contract TicTacToe {
    mapping(address => string) games;
    string board;

    function setBoard(string newBoard) public {
      board = newBoard;
    }

    function getBoard() public view returns (string) {
      return board;
    }

    function getGame(address ownerAddress) public view returns (string) {
      return games[ownerAddress];
    }

    function makeMove(string mark, uint move) public {
      bytes memory tempBoard = bytes(board);
      bytes memory byteMark = bytes(mark);

      tempBoard[move] = byteMark[0];

      board = string(tempBoard);
    }

    function startGame() public {
      games[msg.sender] = "blah";
    }
}
