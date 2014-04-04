#import <OCDSpec2/OCDSpec2.h>
#import "MockUi.h"
#import "Game.h"

OCDSpec2Context(GameSpec) {

  Describe(@"Game", ^{

    __block MockUi *mockUi;
    __block Game *game;

    BeforeEach(^{
        mockUi = [[MockUi alloc] init];
        game = [[Game alloc] initWithUi:mockUi];
    });

    Describe(@"plays the game", ^{

        BeforeEach(^{
            [game startGame];
            [game playGame];
        });

        It(@"prompts user to enter move", ^{
            [ExpectBool(mockUi.promptedMove) toBeTrue];
        });

        It(@"makes a move", ^{
            [ExpectObj([game.board.slots objectAtIndex:1]) toBe:@"O"];
        });

        It(@"displays the board", ^{
            [ExpectBool(mockUi.printedBoard) toBeTrue];
        });

    });

    Describe(@"starts the game", ^{

        BeforeEach(^{
            [game startGame];
        });

        It(@"displays welcome message", ^{
            [ExpectBool(mockUi.welcomedUser) toBeTrue];
        });

        It(@"prompts user to enter board size", ^{
            [ExpectBool(mockUi.promptedBoardSize) toBeTrue];
        });

        It(@"prompts user to enter player one type", ^{
            [ExpectBool(mockUi.promptedPlayerOneType) toBeTrue];
        });

        It(@"prompts user to enter player two type", ^{
            [ExpectBool(mockUi.promptedPlayerTwoType) toBeTrue];
        });

        It(@"prints the board", ^{
            [ExpectBool(mockUi.printedBoard) toBeTrue];
        });

    });

      Describe(@"ends the game", ^{

          It(@"prompts user good bye", ^{
              [game endGame];
              [ExpectBool(mockUi.promptedGoodBye) toBeTrue];
          });


          It(@"prints the board", ^{
              [game endGame];
              [ExpectBool(mockUi.printedBoard) toBeTrue];
          });

          It(@"prompts if the user would like to play again", ^{
              [game endGame];
              [ExpectBool(mockUi.promptedPlayAgain) toBeTrue];
          });

          It(@"displays result", ^{
              Board* newBoard = [[Board alloc] init:3];
              [newBoard replaceSlot:0 withMark:@"X"];
              [newBoard replaceSlot:1 withMark:@"X"];
              [newBoard replaceSlot:2 withMark:@"X"];
              game.board = newBoard;
              [game endGame];
              [ExpectBool(mockUi.promptedWinner) toBeTrue];
          });
      });

      Describe(@"game has instances ", ^{

          BeforeEach(^{
              [game startGame];
          });

          It(@"has a board", ^{
              [ExpectObj(game.board) toExist];
          });

          It(@"has an ui", ^{
              [ExpectObj(game.ui) toExist];
          });

          It(@"has player one", ^{
              [ExpectObj(game.playerOne) toExist];
          });

          It(@"has player two", ^{
              [ExpectObj(game.playerTwo) toExist];
          });

      });

  });

}
