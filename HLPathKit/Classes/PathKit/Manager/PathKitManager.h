//
//  PathKitManager.h
//  PathKit
//
//  Created by huanglin on 2022/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PathKitManager : NSObject

@property (nonatomic, copy) NSString *prePage;
@property (nonatomic, copy) NSString *preLocation;

+ (instancetype)sharedObject;
- (void)setPage:(NSString *)page location:(NSString *)location;
@end

NS_ASSUME_NONNULL_END
