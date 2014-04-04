#import "Ai.h"
#import "../board.h"
#import "../BoardLogic.h"

@implementation Ai

+ (int) getMove:(Board *)board withMark:(NSString *)mark {
    int bestScore = -50;
    int bestIndex = 0;

    NSMutableArray* emptySlots = [board emptySlots];

    for (NSString* slot in emptySlots) {

        Board *tempBoard = [[Board alloc] initWithSlots:[board slots]];
        [tempBoard replaceSlot:[slot intValue]-1 withMark:mark];

        int score = [self minimax:tempBoard withMark:[self getOpponentMark:mark] maxPlayer:NO alpha:-100 beta:100 color:-1 depth:0];

        if (score > bestScore) {
            bestScore = score;
            bestIndex = [slot intValue]-1;
        }
    }

    return bestIndex;
}

+ (int) minimax:(Board*)board withMark:(NSString *)mark maxPlayer:(BOOL)maxPlayer
          alpha:(int)alpha beta:(int)beta color:(int)color depth:(int)depth {

    if ([self gameIsOver:depth withBoard:board]) {

        return [self getScore:board withDepth:depth withMark:mark] * color;

    } else if (maxPlayer) {

        NSMutableArray* emptySlots = [board emptySlots];

        for (NSString* slot in emptySlots) {

            Board *tempBoard = [[Board alloc] initWithSlots:[board slots]];
            [tempBoard replaceSlot:[slot intValue]-1 withMark:mark];

            alpha = MAX(alpha, [self minimax:tempBoard withMark:[self getOpponentMark:mark]
                                maxPlayer:!maxPlayer alpha:alpha beta:beta color:-color depth:depth+1]);

            if (alpha >= beta) { break; }
        }

        return alpha;
    } else {

        NSMutableArray* emptySlots = [board emptySlots];

        for (NSString* slot in emptySlots) {

            Board *tempBoard = [[Board alloc] initWithSlots:[board slots]];
            [tempBoard replaceSlot:[slot intValue]-1 withMark:mark];

            beta = MIN(beta, [self minimax:tempBoard withMark:[self getOpponentMark:mark]
                                   maxPlayer:!maxPlayer alpha:alpha beta:beta color:-color depth:depth+1]);

            if (alpha >= beta) { break; }
        }
        return beta;
    }
}

+ (int) getScore:(Board*)board withDepth:(int)depth withMark:(NSString*)mark {
    if ([[[BoardLogic hasWinner:board] objectForKey:@"winner"] isEqualToString:mark]) {
        return 10 + depth;
    } else if ([BoardLogic isTie:board]) {
        return 0;
    } else {
        return -10 + depth;
    }
}

+ (NSString*) getOpponentMark:(NSString*)mark {
    if ([mark isEqualToString:@"X"]) {
        return @"O";
    }
    return @"X";
}

+ (BOOL) gameIsOver:(int)depth withBoard:(Board*)board {
    return [[[BoardLogic hasWinner:board] objectForKey:@"hasWinner"] isEqualToString:@"YES"] ||
           [BoardLogic isTie:board] ||
           depth == 6;
}

@end
