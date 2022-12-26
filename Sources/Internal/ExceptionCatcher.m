#import "ExceptionCatcher.h"

@implementation _ExceptionCatcher: NSObject

+ (BOOL)rethrowException:(__attribute__((noescape)) void(^)(void))tryBlock error:(__autoreleasing NSError **)error {
    @try {
        tryBlock();
        return YES;
    } @catch (NSException *exception) {
        *error = [[NSError alloc] initWithDomain:exception.name code:0 userInfo:@{
            NSUnderlyingErrorKey: exception,
            NSLocalizedDescriptionKey: exception.reason,
            @"CallStackSymbols": exception.callStackSymbols
        }];

        return NO;
    }
}

+ (NSException * _Nullable)catchException:(__attribute__((noescape)) void(^)(void))tryBlock {
    @try {
        tryBlock();
        return nil;
    }
    @catch (NSException *exception) {
        return exception;
    }
}

@end
