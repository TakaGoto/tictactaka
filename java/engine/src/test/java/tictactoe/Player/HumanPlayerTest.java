package tictactoe.Player;

import com.tictactoe.Board.Board;
import com.tictactoe.Player.HumanPlayer;
import tictactoe.mocks.BoardMock;
import org.junit.Before;
import org.junit.Test;

import static junit.framework.Assert.assertEquals;

public class HumanPlayerTest {
    HumanPlayer human;

    @Before
    public void initialize(){
        human = new HumanPlayer('X');
    }
    @Test public void playerIsHuman(){
        assertEquals(true, human.isHuman());
    }

    @Test public void getHumanMark(){
        assertEquals('X', human.getMark());
    }

    @Test public void humanMakeMove(){
        BoardMock board = new BoardMock(3);
        Board new_board;
        new_board = human.move(board, 5);
        assertEquals("____X____", new_board.getSlots());
    }

    @Test public void humanMakeRightMove(){
        BoardMock board = new BoardMock(3);
        Board new_board;
        new_board = human.move(board, 1);
        assertEquals("X________", new_board.getSlots());
    }
}
