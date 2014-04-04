#import <Foundation/Foundation.h>

@interface Board : NSObject

@property (nonatomic, strong) NSMutableArray *slots;

- (id) init:(int)size;

- (Board*) initWithSlots:(NSMutableArray*)slots;

- (void) createBoard:(int)size;

- (void) replaceSlot:(int)index withMark:(NSString*)mark;

- (BOOL) validSlot:(int)index;

- (NSMutableArray*) emptySlots;

@end
