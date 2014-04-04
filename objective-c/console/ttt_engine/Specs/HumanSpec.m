#import <OCDSpec2/OCDSpec2.h>
#import "HumanPlayer.h"
#import "MockUi.h"
#import "board.h"

OCDSpec2Context(HumanSpec) {

  Describe(@"Human Player", ^{
      __block HumanPlayer *humanPlayer;

      BeforeEach(^{
          humanPlayer = [[HumanPlayer alloc] init:@"X"];
      });

    It(@"has a mark for Human Player", ^{
        [ExpectStr(humanPlayer.mark) toBe:@"X"];
    });

      It(@"makes a move", ^{
          Board* board = [[Board alloc] init:3];
          MockUi* mockUi = [[MockUi alloc] init];

          [humanPlayer makeMoveWith:board andUi:mockUi];

          [ExpectBool(mockUi.promptedMove) toBeTrue];
          [ExpectStr([board.slots objectAtIndex:4]) toBe:@"X"];
      });
  });
}
