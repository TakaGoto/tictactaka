#import "MockIO.h"

@implementation MockIO

@synthesize text;

- (void) write:(NSString *)msg {
    self.text = msg;
}

- (NSString*) readLine:(NSString*)input {
    if ([input  isEqual: @"board size"]) {
        return [NSString stringWithFormat:@"3"];
    } else if ([input isEqual: @"player type"]) {
        return [NSString stringWithFormat:@"h"];
    } else if ([input isEqual: @"player move"]) {
        return [NSString stringWithFormat:@"5"];
    } else if ([input isEqual: @"play again"]) {
        return [NSString stringWithFormat:@"n"];
    } else {
        return [NSString stringWithFormat:@"mock"];
    }
}

@end
