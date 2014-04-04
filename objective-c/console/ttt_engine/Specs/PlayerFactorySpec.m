#import <OCDSpec2/OCDSpec2.h>
#import "PlayerFactory.h"
#import "Player.h"

OCDSpec2Context(PlayerFactorySpec) {
  
  Describe(@"create a player", ^{
    
    It(@"creates a human player", ^{
        id<Player> player = [PlayerFactory create:@"h" withMark:@"X"];
        [ExpectStr(player.mark) toBe:@"X"];
    });
      
    It(@"creates a computer player", ^{
        id<Player> player = [PlayerFactory create:@"c" withMark:@"O"];
        [ExpectStr(player.mark) toBe:@"O"];
    });
  });
  
}
