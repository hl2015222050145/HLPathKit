//
//  RathPathModel.m
//  PathKit
//
//  Created by huanglin on 2022/7/7.
//

#import "RathPathModel.h"


@implementation RathPathModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"curpage:%@ curLocation:%@ prepage:%@ preLocation:%@",self.curPage,self.curLocation,self.prePage,self.preLocation];
}

@end
