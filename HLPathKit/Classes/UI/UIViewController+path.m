//
//  UIViewController+path.m
//  ReportKit
//
//  Created by huanglin on 2022/7/7.
//

#import "UIViewController+path.h"
#import "RathPathModel.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>
#import "UIView+path.h"
#import "PathKitManager.h"

@implementation UIViewController (path)

@dynamic pathModel;
@dynamic currentPageName;

- (NSString *)currentPageName
{
    NSString *name = objc_getAssociatedObject(self, _cmd);
    if(!name){
        name = @"";
        [self setCurrentPageName:name];
    }
    return name;

}

- (void)setCurrentPageName:(NSString *)currentPageName
{
    objc_setAssociatedObject(self, @selector(currentPageName),currentPageName, OBJC_ASSOCIATION_COPY);
    self.pathModel.curPage =  currentPageName;


}
- (RathPathModel *)pathModel
{
    RathPathModel *model = objc_getAssociatedObject(self, _cmd);
    if(!model){
        model = [RathPathModel new];
        model.curName = self.currentPageName;
        [self setPathModel:model];

    }
    return model;
}

- (void)setPathModel:(RathPathModel *)pathModel
{
    objc_setAssociatedObject(self, @selector(pathModel),pathModel, OBJC_ASSOCIATION_RETAIN);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController aspect_hookSelector:@selector(initWithNibName:bundle:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            [(UIViewController *)aspectInfo.instance setupPathIfNeed];
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(initWithCoder:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            [(UIViewController *)aspectInfo.instance setupPathIfNeed];
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            [(UIViewController *)aspectInfo.instance setupViewPathIfNeed];
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(presentViewController:animated:completion:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo){
            
            NSInvocation *invocation = aspectInfo.originalInvocation;
            if([invocation isKindOfClass:[NSInvocation class]]){
                NSUInteger argsCount = invocation.methodSignature.numberOfArguments - 2;
                if(argsCount > 0){
                    NSObject * __unsafe_unretained obj;
                    [invocation getArgument:&obj atIndex:2];
                    if([obj isKindOfClass:[UIViewController class]]){
                        [(UIViewController *)aspectInfo.instance setupPrepathIfNeed:(UIViewController *)obj];
                    }

                }

            }
            
        } error:NULL];
        
    });
}

- (void)setupPathIfNeed
{
    self.pathModel.curPage =  self.currentPageName;
    self.pathModel.curLocation = @"";
}

- (void)setupViewPathIfNeed
{
    self.view.pathModel.prePage = self.pathModel.prePage;
    self.view.pathModel.preLocation = self.pathModel.preLocation;
    self.view.pathModel.curPage =  [self currentPageName];
    self.view.pathModel.curLocation = @"";
}

- (void)setupPrepathIfNeed:(UIViewController *)vc
{
    if([vc isKindOfClass:[UIViewController class]]){
        vc.pathModel.prePage = [PathKitManager sharedObject].prePage;
        vc.pathModel.preLocation = [PathKitManager sharedObject].preLocation;
    }
}


@end
