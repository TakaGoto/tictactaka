#!/usr/bin/env bash

gcc -framework Foundation ttt_console/src/ConsoleIO.m ttt_console/src/ConsoleUi.m ttt_engine/Src/Game.m ttt_engine/Src/board.m ttt_engine/Src/Players/HumanPlayer.m ttt_engine/Src/Players/ComputerPlayer.m ttt_engine/Src/BoardLogic.m ttt_engine/Src/Players/PlayerFactory.m ttt_engine/Src/Players/Ai.m -o bin/playGame ttt_console/playGame.m
