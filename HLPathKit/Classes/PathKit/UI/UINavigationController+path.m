//
//  UINavigationController+path.m
//  ReportKit
//
//  Created by huanglin on 2022/7/8.
//

#import "UINavigationController+path.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>
#import "PathKitManager.h"
#import "UIViewController+path.h"
#import "RathPathModel.h"


@implementation UINavigationController (path)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController aspect_hookSelector:@selector(pushViewController:animated:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            NSInvocation *invocation = aspectInfo.originalInvocation;
            if([invocation isKindOfClass:[NSInvocation class]]){
                NSUInteger argsCount = invocation.methodSignature.numberOfArguments - 2;
                if(argsCount > 0){
                    NSObject * __unsafe_unretained obj;
                    [invocation getArgument:&obj atIndex:2];
                    if([obj isKindOfClass:[UIViewController class]]){
                        [(UINavigationController *)aspectInfo.instance setupPrepathIfNeed:(UIViewController *)obj];
                    }

                }

            }
        } error:NULL];
        
        [UINavigationController aspect_hookSelector:@selector(setViewControllers:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            NSInvocation *invocation = aspectInfo.originalInvocation;
            if([invocation isKindOfClass:[NSInvocation class]]){
                NSUInteger argsCount = invocation.methodSignature.numberOfArguments - 2;
                if(argsCount > 0){
                    NSArray<UIViewController *> * __unsafe_unretained obj;
                    [invocation getArgument:&obj atIndex:2];
                    if([obj isKindOfClass:[NSArray class]]){
                        for (UIViewController *vc in obj) {
                            [(UINavigationController *)aspectInfo.instance setupPrepathIfNeed:vc];
                        }
                    }
                }

            }
        } error:NULL];
    });
}

- (void)setupPrepathIfNeed:(UIViewController *)vc
{
    if([vc isKindOfClass:[UIViewController class]]){
        vc.pathModel.prePage = [PathKitManager sharedObject].prePage;
        NSString *tempStr = [PathKitManager sharedObject].preLocation;
        vc.pathModel.preLocation = [PathKitManager sharedObject].preLocation;
    }
}
@end
