//
//  UIView+path.h
//  ReportKit
//
//  Created by huanglin on 2022/7/7.
//

#import <UIKit/UIKit.h>
@class  RathPathModel;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (path)
@property(nonatomic, strong) RathPathModel *pathModel;
@property(nonatomic, copy) NSString *currentPageName;

- (void)printCurrentPath;
@end

NS_ASSUME_NONNULL_END
