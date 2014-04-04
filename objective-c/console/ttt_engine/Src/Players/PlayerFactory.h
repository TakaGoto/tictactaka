#import "Player.h"

@interface PlayerFactory : NSObject

+ (id<Player>) create:(NSString*)playerType withMark:(NSString*)mark;

@end
