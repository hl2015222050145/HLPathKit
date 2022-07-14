//
//  PathKitManager.m
//  PathKit
//
//  Created by huanglin on 2022/7/8.
//

#import "PathKitManager.h"

@interface PathKitManager()


@end

@implementation PathKitManager

+ (instancetype)sharedObject
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PathKitManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}

- (void)setPage:(NSString *)page location:(NSString *)location
{
    self.prePage = page;
    self.preLocation = location;
}
@end
