//
//  UIView+path .m
//  ReportKit
//
//  Created by huanglin on 2022/7/7.
//

#import "UIView+path.h"
#import "RathPathModel.h"
#import <objc/runtime.h>
#import <Aspects/Aspects.h>
#import "PathKitManager.h"
#import "UIViewController+path.h"

@implementation UIView (path)

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
    self.pathModel.curName = currentPageName;
    [self setupPathIfNeed];
}

- (id)pathModel
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
        [UIView aspect_hookSelector:@selector(didMoveToSuperview) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            [(UIView *)aspectInfo.instance setupPathIfNeed];
        } error:NULL];
        
        [UIView aspect_hookSelector:@selector(hitTest:withEvent:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
            NSInvocation *invocation = aspectInfo.originalInvocation;
            if([invocation isKindOfClass:[NSInvocation class]]){
                NSObject * __unsafe_unretained obj;
                [aspectInfo.originalInvocation getReturnValue:&obj];
                if(obj == aspectInfo.instance){
                    [(UIView *)aspectInfo.instance setupPrePathIfNeeded];
                }
            }
        } error:NULL];
    });
}

- (void)setupPrePathIfNeeded
{
    [[PathKitManager sharedObject] setPage:self.pathModel.curPage location:self.pathModel.curLocation];
}

- (void)setupPathIfNeed
{
    if(self.superview && self.superview.pathModel.curPage){
        self.pathModel.prePage = self.superview.pathModel.prePage;
        self.pathModel.preLocation = self.superview.pathModel.preLocation;
        self.pathModel.curPage = self.superview.pathModel.curPage;
        if(self.superview.pathModel.curLocation){
            if(self.pathModel.curName.length > 0){
                if(self.superview.pathModel.curLocation.length > 0){
                    self.pathModel.curLocation = [NSString stringWithFormat:@"%@/%@",self.superview.pathModel.curLocation,self.pathModel.curName];
                }else{
                    self.pathModel.curLocation = self.pathModel.curName;
                }
            }else{
                self.pathModel.curLocation = self.superview.pathModel.curLocation;
            }
            
            for(UIView *view in self.subviews){
                view.pathModel.curPage = self.superview.pathModel.curPage;
                if(view.pathModel.curName.length > 0){
                    view.pathModel.curLocation = [NSString stringWithFormat:@"%@/%@",self.pathModel.curLocation,view.pathModel.curName];
                }else{
                    view.pathModel.curLocation = self.pathModel.curLocation;
                }
            }
        }
    }else{
        id target = ((UIResponder *)self).nextResponder;
         if ([target isKindOfClass:[UIViewController class]]) {
             self.pathModel = ((UIViewController *)target).pathModel;
         }
    }

}

- (void)printCurrentPath
{
    NSLog(@"printCurrentPath page:%@ location:%@ prePage:%@ preLocation:%@",self.pathModel.curPage,self.pathModel.curLocation,self.pathModel.prePage,self.pathModel.preLocation);
}
@end
