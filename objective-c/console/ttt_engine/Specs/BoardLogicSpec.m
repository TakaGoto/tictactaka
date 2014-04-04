#import <OCDSpec2/OCDSpec2.h>
#import "BoardLogic.h"
#import "board.h"

OCDSpec2Context(BoardLogicSpec) {

  Describe(@"BoardLogic", ^{

    Describe(@"generate winning combinations", ^{

        It(@"generates winning combinations for a 3x3 board", ^{
            NSMutableArray *winningCombinations = [BoardLogic generateWinCombinations:3];
            [ExpectInt([winningCombinations count]) toBe: 8];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"0", @"1", @"2", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"3", @"4", @"5", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"6", @"7", @"8", nil]];

            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"0", @"3", @"6", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"1", @"4", @"7", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"2", @"5", @"8", nil]];

            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"0", @"4", @"8", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"2", @"4", @"6", nil]];
        });

        It(@"generates winning combinations for a 4x4 board", ^{
            NSMutableArray *winningCombinations = [BoardLogic generateWinCombinations:4];
            [ExpectInt([winningCombinations count]) toBe: 10];

            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"0", @"1", @"2", @"3", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"4", @"5", @"6", @"7", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"8", @"9", @"10", @"11", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"12", @"13", @"14", @"15", nil]];

            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"0", @"4", @"8", @"12", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"1", @"5", @"9", @"13", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"2", @"6", @"10", @"14", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"3", @"7", @"11", @"15", nil]];

            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"0", @"5", @"10", @"15", nil]];
            [ExpectArray(winningCombinations) toContain:[NSArray arrayWithObjects:@"3", @"6", @"9", @"12", nil]];
        });

    });

      Describe(@"game state", ^{

          __block Board* board;
          __block Board* bigBoard;

          BeforeEach(^{
              board = [[Board alloc] init:3];
              bigBoard = [[Board alloc] init:4];
          });

          Describe(@"check is game is over", ^{

              It(@"returns true if the board is full", ^{
                  [board replaceSlot:0 withMark:@"X"];
                  [board replaceSlot:1 withMark:@"O"];
                  [board replaceSlot:2 withMark:@"X"];
                  [board replaceSlot:3 withMark:@"X"];
                  [board replaceSlot:4 withMark:@"O"];
                  [board replaceSlot:5 withMark:@"X"];
                  [board replaceSlot:6 withMark:@"O"];
                  [board replaceSlot:7 withMark:@"X"];
                  [board replaceSlot:8 withMark:@"O"];
                  [ExpectBool([BoardLogic isOver:board]) toBeTrue];
              });
          });

          Describe(@"state of the game", ^{

              It(@"returns 'tie' if the game is a tie", ^{
                  [board replaceSlot:0 withMark:@"X"];
                  [board replaceSlot:1 withMark:@"O"];
                  [board replaceSlot:2 withMark:@"X"];
                  [board replaceSlot:3 withMark:@"X"];
                  [board replaceSlot:4 withMark:@"O"];
                  [board replaceSlot:5 withMark:@"X"];
                  [board replaceSlot:6 withMark:@"O"];
                  [board replaceSlot:7 withMark:@"X"];
                  [board replaceSlot:8 withMark:@"O"];
                  NSString* result = [BoardLogic gameState:board];
                  [ExpectStr(result) toBe:@"tie"];
              });

              It(@"returns 'X' if there is no tie and the winner is X", ^{
                  [board replaceSlot:0 withMark:@"X"];
                  [board replaceSlot:1 withMark:@"X"];
                  [board replaceSlot:2 withMark:@"X"];
                  NSString* result = [BoardLogic gameState:board];
                  [ExpectStr(result) toBe:@"X"];
              });
          });

          Describe(@"check if board is full", ^{

              It(@"returns false if the board is not full", ^{
                  [ExpectBool([BoardLogic isFull:board]) toBeFalse];
              });

              It(@"returns true if the board is full", ^{
                  [board replaceSlot:0 withMark:@"X"];
                  [board replaceSlot:1 withMark:@"O"];
                  [board replaceSlot:2 withMark:@"X"];
                  [board replaceSlot:3 withMark:@"X"];
                  [board replaceSlot:4 withMark:@"O"];
                  [board replaceSlot:5 withMark:@"O"];
                  [board replaceSlot:6 withMark:@"X"];
                  [board replaceSlot:7 withMark:@"X"];
                  [board replaceSlot:8 withMark:@"X"];
                  [ExpectBool([BoardLogic isFull:board]) toBeTrue];
              });
          });

          Describe(@"check if game is a tie", ^{

              It(@"return true if the game is a tie", ^{
                  [board replaceSlot:0 withMark:@"X"];
                  [board replaceSlot:1 withMark:@"O"];
                  [board replaceSlot:2 withMark:@"X"];
                  [board replaceSlot:3 withMark:@"X"];
                  [board replaceSlot:4 withMark:@"O"];
                  [board replaceSlot:5 withMark:@"X"];
                  [board replaceSlot:6 withMark:@"O"];
                  [board replaceSlot:7 withMark:@"X"];
                  [board replaceSlot:8 withMark:@"O"];
                  [ExpectBool([BoardLogic isTie:board]) toBeTrue];

              });

              It(@"returns false if the game is not a tie", ^{
                  [ExpectBool([BoardLogic isTie:board]) toBeFalse];
              });
          });

          Describe(@"check if game has a winner", ^{

              It(@"return true if X is a winner on a 3x3", ^{
                  [board replaceSlot:3 withMark:@"X"];
                  [board replaceSlot:4 withMark:@"X"];
                  [board replaceSlot:5 withMark:@"X"];
                  NSMutableDictionary *hasWinner = [BoardLogic hasWinner:board];
                  [ExpectObj([hasWinner objectForKey:@"hasWinner"]) toBe:@"YES"];
                  [ExpectObj([hasWinner objectForKey:@"winner"]) toBe:@"X"];
              });

              It(@"return true if O is a winneron a 3x3", ^{
                  [board replaceSlot:0 withMark:@"O"];
                  [board replaceSlot:1 withMark:@"O"];
                  [board replaceSlot:2 withMark:@"O"];
                  NSMutableDictionary *hasWinner = [BoardLogic hasWinner:board];
                  [ExpectObj([hasWinner objectForKey:@"hasWinner"]) toBe:@"YES"];
                  [ExpectObj([hasWinner objectForKey:@"winner"]) toBe:@"O"];
              });

              It(@"return true if X is a winner on a 4x4", ^{
                  [bigBoard replaceSlot:4 withMark:@"X"];
                  [bigBoard replaceSlot:5 withMark:@"X"];
                  [bigBoard replaceSlot:6 withMark:@"X"];
                  [bigBoard replaceSlot:7 withMark:@"X"];
                  NSMutableDictionary *hasWinner = [BoardLogic hasWinner:bigBoard];
                  [ExpectObj([hasWinner objectForKey:@"hasWinner"]) toBe:@"YES"];
                  [ExpectObj([hasWinner objectForKey:@"winner"]) toBe:@"X"];
              });

              It(@"return true if O is a winneron a 4x4", ^{
                  [bigBoard replaceSlot:0 withMark:@"O"];
                  [bigBoard replaceSlot:5 withMark:@"O"];
                  [bigBoard replaceSlot:10 withMark:@"O"];
                  [bigBoard replaceSlot:15 withMark:@"O"];
                  NSMutableDictionary *hasWinner = [BoardLogic hasWinner:bigBoard];
                  [ExpectObj([hasWinner objectForKey:@"hasWinner"]) toBe:@"YES"];
                  [ExpectObj([hasWinner objectForKey:@"winner"]) toBe:@"O"];
              });

              It(@"return false if there is no winner", ^{
                  NSMutableDictionary *hasWinner = [BoardLogic hasWinner:board];
                  [ExpectObj([hasWinner objectForKey:@"hasWinner"]) toBe:@"NO"];
              });
          });
      });

  });

}
