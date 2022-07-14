//
//  RathPathModel.h
//  PathKit
//
//  Created by huanglin on 2022/7/7.
//

#import <Foundation/Foundation.h>


@interface RathPathModel : NSObject
@property (nonatomic,copy)NSString *curName;  // 当前名称
@property (nonatomic,copy)NSString *curPage;  // 页面
@property (nonatomic,copy)NSString *curLocation;  // 当前页面下位置

@property (nonatomic,copy)NSString *prePage;  // 从哪个页面来
@property (nonatomic,copy)NSString *preLocation;  // 从哪个页面点击而来
@end

