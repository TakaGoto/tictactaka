#import <OCDSpec2/OCDSpec2.h>
#import "board.h"
#import "Ai.h"

OCDSpec2Context(AiSpec) {

  Describe(@"Impossible Ai", ^{

    Describe(@"getMove", ^{
        __block Board* board;


        BeforeEach(^{
            board = [[Board alloc] init:3];
        });

        It(@"returns slot 7 to win the game", ^{
            [board replaceSlot:0 withMark:@"X"];
            [board replaceSlot:1 withMark:@"O"];
            [board replaceSlot:2 withMark:@"X"];

            [board replaceSlot:3 withMark:@"X"];
            [board replaceSlot:4 withMark:@"O"];
            [board replaceSlot:5 withMark:@"X"];

            [board replaceSlot:6 withMark:@"O"];
            [board replaceSlot:8 withMark:@"O"];

            [ExpectInt([Ai getMove:board withMark:@"O"]) toBe:7];
        });

        It(@"returns slot 6 to win the game", ^{
            [board replaceSlot:0 withMark:@"X"];
            [board replaceSlot:1 withMark:@"O"];
            [board replaceSlot:2 withMark:@"O"];

            [board replaceSlot:3 withMark:@"X"];
            [board replaceSlot:4 withMark:@"O"];
            [board replaceSlot:5 withMark:@"X"];

            [board replaceSlot:7 withMark:@"X"];

            [ExpectInt([Ai getMove:board withMark:@"O"]) toBe:6];
        });

        It(@"it makes a smart move at the beginning", ^{
            [board replaceSlot:0 withMark:@"O"];
            [board replaceSlot:4 withMark:@"X"];
            [board replaceSlot:8 withMark:@"X"];

            [ExpectInt([Ai getMove:board withMark:@"O"]) toBe:2];
        });

        It(@"makes a win move instead of blocking", ^{
            [board replaceSlot:0 withMark:@"O"];
            [board replaceSlot:3 withMark:@"O"];
            [board replaceSlot:1 withMark:@"X"];
            [board replaceSlot:4 withMark:@"X"];

            [ExpectInt([Ai getMove:board withMark:@"O"]) toBe:6];
        });
    });

    Describe(@"minimax", ^{
        __block Board* board;

        BeforeEach(^{
            board = [[Board alloc] init:3];
        });

        It(@"returns 2, a win, for last move", ^{
            [board replaceSlot:0 withMark:@"X"];
            [board replaceSlot:1 withMark:@"O"];
            [board replaceSlot:2 withMark:@"X"];

            [board replaceSlot:3 withMark:@"X"];
            [board replaceSlot:4 withMark:@"O"];
            [board replaceSlot:5 withMark:@"X"];

            [board replaceSlot:6 withMark:@"O"];
            [board replaceSlot:8 withMark:@"O"];

            [ExpectInt([Ai minimax:board withMark:@"O"
                         maxPlayer:NO alpha:-50 beta:50 color:1 depth:0]) toBe:9];
        });

        It(@"returns 0, a tie, for last move", ^{
            [board replaceSlot:0 withMark:@"O"];
            [board replaceSlot:1 withMark:@"O"];
            [board replaceSlot:2 withMark:@"X"];

            [board replaceSlot:3 withMark:@"X"];
            [board replaceSlot:4 withMark:@"X"];
            [board replaceSlot:5 withMark:@"O"];

            [board replaceSlot:6 withMark:@"O"];
            [board replaceSlot:8 withMark:@"X"];

            [ExpectInt([Ai minimax:board withMark:@"O" maxPlayer:NO
                             alpha:-50 beta:50 color:-1 depth:0]) toBe:0];
        });

        It(@"returns 1 if the game is already won", ^{
            [board replaceSlot:0 withMark:@"O"];
            [board replaceSlot:1 withMark:@"O"];
            [board replaceSlot:2 withMark:@"O"];

            [board replaceSlot:3 withMark:@"X"];
            [board replaceSlot:4 withMark:@"O"];
            [board replaceSlot:5 withMark:@"X"];

            [board replaceSlot:6 withMark:@"O"];
            [board replaceSlot:8 withMark:@"X"];

            [ExpectInt([Ai minimax:board withMark:@"X" maxPlayer:NO alpha:-50 beta:50 color:-1 depth:0]) toBe:10];
        });

        It(@"returns 0 if the game is already tie", ^{
            [board replaceSlot:0 withMark:@"O"];
            [board replaceSlot:1 withMark:@"X"];
            [board replaceSlot:2 withMark:@"O"];

            [board replaceSlot:3 withMark:@"O"];
            [board replaceSlot:4 withMark:@"X"];
            [board replaceSlot:5 withMark:@"O"];

            [board replaceSlot:6 withMark:@"X"];
            [board replaceSlot:7 withMark:@"O"];
            [board replaceSlot:8 withMark:@"X"];

            [ExpectInt([Ai minimax:board withMark:@"X"  maxPlayer:NO alpha:-50 beta:50 color:-1 depth:0]) toBe:0];
        });

        It(@"returns 0 instead of -1, making the game a tie", ^{
            [board replaceSlot:0 withMark:@"O"];
            [board replaceSlot:1 withMark:@"X"];
            [board replaceSlot:2 withMark:@"O"];

            [board replaceSlot:3 withMark:@"O"];
            [board replaceSlot:4 withMark:@"X"];
            [board replaceSlot:5 withMark:@"X"];

            [board replaceSlot:6 withMark:@"X"];

            [ExpectInt([Ai minimax:board withMark:@"O"  maxPlayer:NO alpha:-50 beta:50 color:-1 depth:0]) toBe:0];
        });

        It(@"returns 1 instead of 0, winning the game instead of a tie", ^{
            [board replaceSlot:0 withMark:@"O"];
            [board replaceSlot:1 withMark:@"X"];
            [board replaceSlot:2 withMark:@"O"];

            [board replaceSlot:3 withMark:@"O"];
            [board replaceSlot:4 withMark:@"X"];
            [board replaceSlot:5 withMark:@"X"];

            [board replaceSlot:6 withMark:@"X"];

            [ExpectInt([Ai minimax:board withMark:@"X" maxPlayer:NO alpha:-50 beta:50 color:1 depth:0]) toBe:0];
        });

        It(@"returns 1 instead of -1, winning the game instead of a loss", ^{
            [board replaceSlot:0 withMark:@"O"];
            [board replaceSlot:1 withMark:@"X"];
            [board replaceSlot:2 withMark:@"O"];

            [board replaceSlot:3 withMark:@"O"];
            [board replaceSlot:4 withMark:@"X"];
            [board replaceSlot:5 withMark:@"X"];

            [board replaceSlot:8 withMark:@"X"];

            [ExpectInt([Ai minimax:board withMark:@"O" maxPlayer:NO alpha:-50 beta:50 color:1 depth:0]) toBe:0];
        });
    });
  });

}
