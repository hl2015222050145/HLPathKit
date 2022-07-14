//
//  UIViewController+path.h
//  ReportKit
//
//  Created by huanglin on 2022/7/7.
//

#import <UIKit/UIKit.h>

@class RathPathModel;

@interface UIViewController (path)

@property(nonatomic, strong) RathPathModel *pathModel;
@property(nonatomic, copy) NSString *currentPageName;

@end


