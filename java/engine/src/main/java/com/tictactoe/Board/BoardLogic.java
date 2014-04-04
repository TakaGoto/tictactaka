package com.tictactoe.Board;

public class BoardLogic {
    private Board board;
    private int[][] winCombs;

    public BoardLogic(Board board) {
        this.board = board;
        generateWinCombs();
    }

    public void generateWinCombs() {
        int[][] verticalComb = getVerticalWinCombs();
        int[][] horizontalComb = getHorizontalWinCombs();
        int[][] diagonalComb = getDiagonalWinCombs();

        winCombs = new int[(board.getLength() * 2) + 2][];

        System.arraycopy(verticalComb, 0, winCombs, 0, verticalComb.length);
        System.arraycopy(horizontalComb, 0, winCombs, verticalComb.length, horizontalComb.length);
        System.arraycopy(diagonalComb, 0, winCombs, horizontalComb.length + verticalComb.length, diagonalComb.length);
    }

    public boolean hasWinner() {
        String slots = "";
        for (int[] winComb : winCombs) {
            for (int aWinComb : winComb) slots += getSlot(aWinComb);
            if(slots.equals("XXXX") || slots.equals("XXX")) return true;
            if(slots.equals("OOOO") || slots.equals("OOO")) return true;
            slots = "";
        }
        return false;
    }

    public char winner() {
        String slots = "";
        for (int[] winComb : winCombs) {
            for (int aWinComb : winComb) slots += getSlot(aWinComb);
            if(slots.equals("XXXX") || slots.equals("XXX")) return slots.charAt(0);
            if(slots.equals("OOOO") || slots.equals("OOO")) return slots.charAt(0);
            slots = "";
        }
        return ' ';
    }

    public boolean tie() {
        return !hasWinner() && full();
    }

    public boolean full() {
        for(int i=0; i < board.getSlots().length(); i++) if (board.getSlots().charAt(i) == '_') return false;
        return true;
    }

    public char getSlot(int index) {
        return board.getSlots().charAt(index - 1);
    }

    public boolean isOver() {
        return tie() || hasWinner();
    }

    public int[][] getCombs() {
        return winCombs;
    }

    public void setBoard(Board board) {
        this.board = board;
    }

    public Board getBoard() {
        return board;
    }

    public int[][] getVerticalWinCombs() {
        int length = board.getLength();
        int[][] vert = new int[length][length];
        int count = 1;
        for(int k=0; k < length; k++){
            for(int i=0; i < length; i++){
                vert[i][k] = count;
                count++;
            }
        }
        return vert;
    }

    public int[][] getHorizontalWinCombs() {
        int length = board.getLength();
        int[][] horizontal = new int[length][length];
        int count = 1;
        for(int k=0; k < length; k++) {
            for(int i=0; i < length; i++) {
                horizontal[k][i] = count;
                count++;
            }
        }
        return horizontal;
    }

    public int[][] getDiagonalWinCombs() {
        int length = board.getLength();
        int[][] diagonal = new int[2][length];
        int leftDiagonalCount = 1;
        int rightDiagonalCount = length;
        for(int i=0; i < length; i++) {
            diagonal[0][i] = leftDiagonalCount;
            diagonal[1][i] = rightDiagonalCount;
            leftDiagonalCount += length + 1;
            rightDiagonalCount += length - 1;
        }
        return diagonal;
    }

    public char findPlayerTurn(String board) {
        int spotsOpen = board.replaceAll("[_]", "").length();
        if(spotsOpen % 2 == 0) return 'X';
        else return 'O';
    }
}
