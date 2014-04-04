#import <Foundation/Foundation.h>

@protocol IO

@property (nonatomic, strong) NSString* text;

- (void) write:(NSString*)msg;

- (NSString*) readLine:(NSString*)input;

@end
