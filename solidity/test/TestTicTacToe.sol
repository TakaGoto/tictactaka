pragma solidity ^0.5.8;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/tictactoe.sol";

contract TestTicTacToe {
  function testSetsBoard() public {
    TicTacToe ttt = new TicTacToe();

    string memory board = "0123456789";
    ttt.setBoard(board);
    Assert.equal(ttt.getBoard(), board, "can get and set board");
  }

  function testMakeFirstMove() public {
    TicTacToe ttt = new TicTacToe();

    string memory board = "012345678";
    ttt.setBoard(board);
    ttt.makeMove(0);

    Assert.equal("X12345678", ttt.getBoard(), "can make move");
  }

  function testMakeSecondMove() public {
    TicTacToe ttt = new TicTacToe();

    string memory board = "X12345678";
    ttt.setBoard(board);
    ttt.makeMove(1);

    Assert.equal("XO2345678", ttt.getBoard(), "can make move");
  }

  function testUndoMove() public {
    TicTacToe ttt = new TicTacToe();

    string memory board = "01234567X";
    ttt.setBoard(board);
    ttt.undoMove(8);

    Assert.equal("012345678", ttt.getBoard(), "can undo move");
  }

  // function testStartGame() public {
  //   // TicTacToe ttt = new TicTacToe(DeployedAddresses.tictactoe());

  //   // ttt.startGame();

  //   // Assert.equal(ttt.getGame(DeployedAddresses.tictactoe()), "woooo", "can start game");
  // }
}
