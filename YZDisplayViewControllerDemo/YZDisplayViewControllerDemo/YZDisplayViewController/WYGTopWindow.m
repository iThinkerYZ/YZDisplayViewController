//
//  WYGTopWindow.m
//  企额贷
//
//  Created by 张德荣 on 15/12/8.
//  Copyright © 2015年 Sameway. All rights reserved.
//

#import "WYGTopWindow.h"

@implementation WYGTopWindow
static UIWindow *window_;
//初始化window
+ (void)load {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        window_ = [[UIWindow alloc] init];
        window_.backgroundColor = [UIColor clearColor];
        window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
        window_.windowLevel = UIWindowLevelAlert ;
        [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
        window_.hidden = NO;
    });
   
}

+ (void)show {
     
}
+ (void)hide {
    window_.hidden = YES;
}
// 监听窗口点击
+ (void)windowClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}
+ (void)searchScrollViewInView:(UIView *)superview {
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && [self isShowingOnKeyWindow: subview]) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 递归继续查找子控件
        [self searchScrollViewInView:subview];
    }
}
+ (BOOL)isShowingOnKeyWindow:(UIView *)view {
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:view.frame fromView:view.superview];
    CGRect winBounds = keyWindow.bounds;
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !view.isHidden && view.alpha > 0.01 && view.window == keyWindow && intersects;
}

@end
