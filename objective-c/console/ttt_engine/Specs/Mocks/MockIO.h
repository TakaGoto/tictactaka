#import "IO.h"

@interface MockIO : NSObject <IO>

@property (nonatomic, strong) NSString* text;

- (void) write:(NSString*)msg;

- (NSString*) readLine:(NSString*)input;

@end
