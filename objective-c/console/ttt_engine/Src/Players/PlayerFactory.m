#import "PlayerFactory.h"
#import "Player.h"
#import "HumanPlayer.h"
#import "ComputerPlayer.h"

@implementation PlayerFactory

+ (id<Player>) create:(NSString*)playerType withMark:(NSString*)mark {
    if ([playerType isEqualToString:@"h"]) {
        return [[HumanPlayer alloc] init:mark];
    } else {
        return [[ComputerPlayer alloc] init:mark];
    }
}

@end
