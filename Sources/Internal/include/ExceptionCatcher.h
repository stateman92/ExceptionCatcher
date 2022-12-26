#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface _ExceptionCatcher: NSObject

+ (BOOL)rethrowException:(__attribute__((noescape)) void(^)(void))tryBlock error:(__autoreleasing NSError **)error;
+ (NSException * _Nullable)catchException:(__attribute__((noescape)) void(^)(void))tryBlock;

@end

NS_ASSUME_NONNULL_END
