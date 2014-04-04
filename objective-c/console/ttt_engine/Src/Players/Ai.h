#import <Foundation/Foundation.h>
#import "../board.h"

@interface Ai : NSObject

+ (int) getMove:(Board*)board withMark:(NSString*)mark;

+ (int) minimax:(Board*)board withMark:(NSString*)mark maxPlayer:(BOOL)maxPlayer
          alpha:(int)alpha beta:(int)beta color:(int)color depth:(int)depth;

+ (int) getScore:(Board*)board withDepth:(int)depth withMark:(NSString*)mark;

@end