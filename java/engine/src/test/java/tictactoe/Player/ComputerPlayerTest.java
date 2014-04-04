package tictactoe.Player;

import com.tictactoe.Board.Board;
import com.tictactoe.Player.ComputerPlayer;
import tictactoe.mocks.BoardMock;
import org.junit.Before;
import org.junit.Test;

import static junit.framework.Assert.assertEquals;

public class ComputerPlayerTest {
    ComputerPlayer comp;
    @Before public void setUp() throws Exception {
        comp = new ComputerPlayer('O');
    }

    @Test public void computerIsNotHuman(){
        assertEquals(false, comp.isHuman());
    }

    @Test public void getComputerMark(){
        assertEquals('O', comp.getMark());
    }

    @Test public void makeComputerMove(){
        BoardMock board = new BoardMock(3);
        Board new_board;
        new_board = comp.move(board, 5);
        assertEquals("O________", new_board.getSlots());
    }
}
