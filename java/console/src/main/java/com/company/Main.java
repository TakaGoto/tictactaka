package com.company;

import com.tictactoe.Game;

import java.io.InputStreamReader;
import java.io.Reader;

public class Main {

    public static void main(String[] args) {
        Reader reader = new InputStreamReader(System.in);
        ConsoleUi ui = new ConsoleUi(reader);
        Game game = new Game(ui);
        game.playGame();
    }
}
