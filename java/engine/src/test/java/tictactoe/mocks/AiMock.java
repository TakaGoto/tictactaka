package tictactoe.mocks;

import com.tictactoe.Board.Board;
import com.tictactoe.Player.Player;

public class AiMock  implements Player {
    private char mark;

    public AiMock(char mark) {
        this.mark = mark;
    }

    public char getMark() {
        return mark;
    }

    public boolean isHuman() {
        return false;
    }

    public Board move(Board board, int index) {
        board.setSlots("____X____");
        return board;
    }
}
