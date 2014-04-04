#import <Foundation/Foundation.h>
#import "board.h"

@interface BoardLogic : NSObject

+ (NSMutableArray*) generateWinCombinations:(int)boardSize;

+ (void) horizontalCombinations:(int)boardSize withCombinations:(NSMutableArray*)combinations;

+ (void) verticalCombinations:(int)boardSize withCombinations:(NSMutableArray*)combinations;

+ (void) diagonalCombinations:(int)boardSize withCombinations:(NSMutableArray*)combinations;

+ (NSString*) gameState:(Board*)board;

+ (BOOL) isOver:(Board*)board;

+ (BOOL) isFull:(Board*)board;

+ (BOOL) isTie:(Board*)board;

+ (NSMutableDictionary*) hasWinner:(Board*)board;

@end
