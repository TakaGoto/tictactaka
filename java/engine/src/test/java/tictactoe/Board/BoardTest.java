package tictactoe.Board;

import com.tictactoe.Board.Board;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;

import static junit.framework.Assert.assertEquals;

public class BoardTest {
    Board board;
    @Before public void initialize(){
        board = new Board(3);
    }

    @Test public void boardShouldHaveLength(){
        assertEquals(3, board.getLength());
    }

    @Test public void boardShouldHaveSlots(){
        assertEquals("_________", board.getSlots());
    }

    @Test public void createFourByFourSlots(){
        Board newBoard = new Board(4);
        board.createSlots();
        assertEquals("________________", newBoard.getSlots());
    }

    @Test public void BoardCanHaveFourByFour(){
        Board newBoard = new Board(4);
        newBoard.setMove('X', 1);
        assertEquals("X_______________", newBoard.getSlots());
    }

    @Test public void boardSetsMoveForX(){
        board.setMove('X', 5);
        assertEquals("____X____", board.getSlots());
    }

    @Test public void boardSetsMoveForO(){
        board.setMove('O', 5);
        assertEquals("____O____", board.getSlots());
    }

    @Test public void boardSetsMultipleMoves(){
        int[] moves = {1, 2, 3};
        board.setMoves('X', moves);
        assertEquals("XXX______", board.getSlots());
    }

    @Test public void getSlots(){
        assertEquals("_________", board.getSlots());
    }

    @Test public void returnEmptySlot(){
        board.setMoves('X', new int[] {1, 2, 3, 4, 5, 6, 7});
        ArrayList list = new ArrayList(){};
        list.add(8);
        list.add(9);
        assertEquals(list, board.getEmptySlots());
    }

    @Test public void returnNoEmptySlots(){
        board.setMoves('X', new int[] {1, 2, 3, 4, 5, 6, 7, 8, 9});
        ArrayList list = new ArrayList(){};
        assertEquals(list, board.getEmptySlots());
    }

    @Test public void undoBoardMove(){
        board.setMove('X', 5);
        board.undoMove(5);
        assertEquals("_________", board.getSlots());
    }

    @Test public void TestString(){
        String a = "a";
        System.out.println(a);
    }

    @Test public void checkBoardIsEmpty() {
        assertEquals(true, board.isEmpty());
    }

    @Test public void checkBoardIsNotEmpty() {
        board.setMove('X', 5);
        assertEquals(false, board.isEmpty());
    }

    @Test public void validateMoveIsValid() {
        assertEquals(true, board.moveIsValid(5));
    }

    @Test public void validateMoveIsNotValid() {
        assertEquals(false, board.moveIsValid(500));
    }

    @Test public void setMoveWithStringAsNumber() {
        board.setMove('X', "5");
        assertEquals("____X____", board.getSlots());
    }

    @Test public void setMoveDoesntWorkWithNullString() {
        board.setMove('X', "");
        assertEquals("_________", board.getSlots());
    }
}
