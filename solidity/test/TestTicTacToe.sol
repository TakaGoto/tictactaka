pragma solidity ^0.4.19;

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

  function testMakeMove() public {
    TicTacToe ttt = new TicTacToe();

    string memory board = "0123456789";
    ttt.setBoard(board);
    ttt.makeMove("X", 0);

    Assert.equal("X123456789", ttt.getBoard(), "can make move");
  }

  function testStartGame() public {
    TicTacToe ttt = new TicTacToe(DeployedAddresses.tictactoe());

    ttt.startGame();

    Assert.equal(ttt.getGame(DeployedAddresses.tictactoe()), "woooo", "can start game");
  }
}
