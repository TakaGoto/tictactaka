#import "Board.h"

@implementation Board

@synthesize slots;

- (id) init:(int)size {
    if ((self = [super init])) {
        [self createBoard:size];
    }
    return (self);
}

- (Board*) initWithSlots:(NSMutableArray *)newSlots {
    self = [super init];

    if (self) {
        slots = [NSMutableArray arrayWithArray:newSlots];
    }

    return (self);
}

- (void) createBoard:(int)size {
    NSMutableArray *generatedBoard = [NSMutableArray array];
    int counter = 1;

    for(int row = 0; row < size; ++row) {
        for(int col = 0; col < size; ++col) {
            [generatedBoard addObject:[NSString stringWithFormat:@"%d", counter]];
            counter++;
        }
    }
    self.slots = generatedBoard;
}

- (void) replaceSlot:(int)index withMark:(NSString*)mark {
    [slots replaceObjectAtIndex:index withObject:mark];
}

- (BOOL) validSlot:(int)index {
    return index <= [self.slots count] &&
           index > 0 &&
           ![[self.slots objectAtIndex:index-1] isEqualToString:@"X"] &&
           ![[self.slots objectAtIndex:index-1] isEqualToString:@"O"];
}

- (NSMutableArray*) emptySlots {
  NSMutableArray* emptySlots = [[NSMutableArray alloc] initWithCapacity:[self.slots count]];

  for(NSString *slot in self.slots) {
    if([slot intValue] != 0) {
      [emptySlots addObject:slot];
    }
  }
  return emptySlots;
}

@end
