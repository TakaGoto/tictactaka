package tictactoe.Board;

import com.tictactoe.Board.Board;
import com.tictactoe.Board.BoardLogic;
import com.tictactoe.Player.ComputerPlayer;
import com.tictactoe.Player.HumanPlayer;
import org.junit.Before;
import org.junit.Test;

import static junit.framework.Assert.assertEquals;
import static org.junit.Assert.assertArrayEquals;

public class BoardLogicTest {
    Board board;
    BoardLogic boardLogic;

    @Before public void initialize(){
        board = new Board(3);
        boardLogic = new BoardLogic(board);
    }

    @Test public void hasWinnerIsTrue(){
        int[] moves = {1, 2, 3};
        board.setMoves('X', moves);
        assertEquals(true, boardLogic.hasWinner());
    }

    @Test public void hasWinnerIsFalse(){
        int[] moves = {1, 2};
        board.setMoves('X', moves);
        assertEquals(false, boardLogic.hasWinner());
    }

    @Test public void hasWinnerForFourByFour() {
        Board board = new Board(4);
        BoardLogic boardLogic1 = new BoardLogic(board);
        int[] moves = {1, 5, 9, 13};
        board.setMoves('X', moves);
        assertEquals(true, boardLogic1.hasWinner());
    }

    @Test public void getsWinnerForFourByFour() {
        Board board = new Board(4);
        BoardLogic boardLogic1 = new BoardLogic(board);
        int[] moves = {1, 5, 9, 13};
        board.setMoves('X', moves);
        assertEquals('X', boardLogic1.winner());
    }

    @Test public void shouldNotBeWinner() {
        Board board = new Board(4);
        BoardLogic boardLogic1 = new BoardLogic(board);
        int[] moves = {1, 2, 3};
        board.setMoves('X', moves);
        assertEquals(' ', boardLogic1.winner());
    }


    @Test public void hasWinnerIsFalseForEmptyBoard(){
        assertEquals(false, boardLogic.hasWinner());
    }

    @Test public void winnerIsX(){
        int[] moves = {1, 2, 3};
        board.setMoves('X', moves);
        assertEquals('X', boardLogic.winner());
    }

    @Test public void winnerIsO(){
        int[] moves = {1, 2, 3};
        board.setMoves('O', moves);
        assertEquals('O', boardLogic.winner());
    }

    @Test public void itIsATie(){
        int[] xMoves = {1, 3, 5, 8};
        int[] oMoves = {2, 4, 6, 7, 9};
        board.setMoves('X', xMoves);
        board.setMoves('O', oMoves);
        assertEquals(true, boardLogic.tie());
    }

    @Test public void itIsNotTie(){
        int[] xMoves = {1, 3, 5};
        int[] oMoves = {2, 4, 6, 7, 9};
        board.setMoves('X', xMoves);
        board.setMoves('O', oMoves);
        assertEquals(false, boardLogic.tie());
    }
        @Test public void boardIsFull(){
        board.setSlots("XOXOXOOXO");
        assertEquals(true, boardLogic.full());
    }

    @Test public void boardIsNotFull(){
        assertEquals(false, boardLogic.full());
    }

    @Test public void createWinningCombinations(){
        int[][] winComb = {{1, 4, 7}, {2, 5, 8}, {3, 6, 9},
                           {1, 2, 3}, {4, 5, 6}, {7, 8, 9},
                           {1, 5, 9}, {3, 5, 7}};
        boardLogic.generateWinCombs();
        assertArrayEquals(winComb, boardLogic.getCombs());
    }

    @Test public void createWinCombForFourByFour(){
        Board newBoard = new Board(4);
        BoardLogic getWinComb = new BoardLogic(newBoard);

        int[][] winComb = {{1, 5, 9, 13}, {2, 6, 10, 14}, {3, 7, 11, 15},
                            {4, 8, 12, 16}, {1, 2, 3, 4}, {5, 6, 7, 8},
                            {9, 10, 11, 12}, {13, 14, 15, 16}, {1, 6, 11, 16}, {4, 7, 10, 13}};
        assertArrayEquals(winComb, getWinComb.getCombs());
    }

    @Test public void gameIsOver(){
        int[] xMoves = {1, 2, 3};
        board.setMoves('X', xMoves);
        assertEquals(true, boardLogic.isOver());
    }

    @Test public void gameIsNotOver(){
        int[] xMoves = {1, 2};
        board.setMoves('X', xMoves);
        assertEquals(false, boardLogic.isOver());
    }
    @Test public void gameIsNotOverWhenTie(){
        int[] xMoves = {1, 3, 5, 8};
        int[] oMoves = {2, 4, 6, 7, 9};
        board.setMoves('X', xMoves);
        board.setMoves('O', oMoves);
        assertEquals(true, boardLogic.isOver());
    }

    @Test public void gameIsOverWithMoves(){
        board.setMoves('X', new int[]{1, 3, 7, 9});
        board.setMoves('O', new int[]{4, 5, 6});
        assertEquals(true, boardLogic.isOver());
    }

    @Test public void SetGameLogicBoard(){
        Board newBoard = new Board(4);
        boardLogic.setBoard(newBoard);
        assertEquals(newBoard, boardLogic.getBoard());
    }

    @Test public void getVerticalWinCombsForFourByFour(){
        Board newBoard = new Board(4);
        boardLogic.setBoard(newBoard);
        int[][] horizontalWinComb = {{1, 5, 9, 13}, {2, 6, 10, 14}, {3, 7, 11, 15}, {4, 8, 12, 16}};
        assertArrayEquals(horizontalWinComb, boardLogic.getVerticalWinCombs());
    }

    @Test public void getVerticalWinCombsForThreeByThree(){
        Board newBoard = new Board(3);
        boardLogic.setBoard(newBoard);
        int[][] horizontalWinComb = {{1, 4, 7}, {2, 5, 8}, {3, 6, 9}};
        assertArrayEquals(horizontalWinComb, boardLogic.getVerticalWinCombs());
    }

    @Test public void getHorizontalWinCombsForThreeByThree(){
        Board newBoard = new Board(3);
        boardLogic.setBoard(newBoard);
        int[][] verticalWinComb = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
        assertArrayEquals(verticalWinComb, boardLogic.getHorizontalWinCombs());
    }
    @Test public void getHorizontalWinCombsForFourByFour(){
        Board newBoard = new Board(4);
        boardLogic.setBoard(newBoard);
        int[][] horizontalWinComb = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10, 11, 12}, {13, 14, 15, 16}};
        assertArrayEquals(horizontalWinComb, boardLogic.getHorizontalWinCombs());
    }

    @Test public void getDiagonalWinCombsForThreeByThree(){
        Board newBoard = new Board(3);
        boardLogic.setBoard(newBoard);
        int[][] diagonalWinComb = {{1, 5, 9}, {3, 5, 7}};
        assertArrayEquals(diagonalWinComb, boardLogic.getDiagonalWinCombs());
    }

    @Test public void getDiagonalWinCombsForFourByFour(){
        Board newBoard = new Board(4);
        boardLogic.setBoard(newBoard);
        int[][] diagonalWinComb = {{1, 6, 11, 16}, {4, 7, 10, 13}};
        assertArrayEquals(diagonalWinComb, boardLogic.getDiagonalWinCombs());
    }

    @Test public void returnsTheCorrectPlayersTurn() {
        assertEquals('X', boardLogic.findPlayerTurn("_________"));
    }

    @Test public void returnsTheCorrectPlayersTurnOnFourByFour() {
        assertEquals('X', boardLogic.findPlayerTurn("________________"));
    }

    @Test public void returnsCorrectPlayerTurnDuringGame() {
        assertEquals('X', boardLogic.findPlayerTurn("XO_______"));
    }

    @Test public void returnsPlayerTwoCorrectPlayerTurnDuringGame() {
        assertEquals('O', boardLogic.findPlayerTurn("XOXOX____"));
    }
}
