//
//  YZJRViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZJRViewController.h"

#import "ChildViewController.h"

@implementation YZJRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"今日头条";
    
    // 模仿网络延迟，0.2秒后，才知道有多少标题
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
        // 移除之前所有子控制器
        [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
        
        // 把对应标题保存到控制器中，并且成为子控制器，才能刷新
        // 添加所有新的子控制器
        [self setUpAllViewController];
        
        // 注意：必须先确定子控制器
        [self refreshDisplay];
        
    });
    
    /* 方式一 
     
     // 标题渐变
     self.isShowTitleGradient = YES;
     
     // 标题填充模式
     self.titleColorGradientStyle = YZTitleColorGradientStyleFill;
     
     */
    
   
    
    /*  方式二 */
//    [self setUpTitleGradient:^(BOOL *isShowTitleGradient, YZTitleColorGradientStyle *titleColorGradientStyle, CGFloat *startR, CGFloat *startG, CGFloat *startB, CGFloat *endR, CGFloat *endG, CGFloat *endB) {
//        
//        // 标题渐变
//        *isShowTitleGradient = YES;
//        
//        // 标题填充模式
//        *titleColorGradientStyle = YZTitleColorGradientStyleRGB;
//    }];
    
    /*  方式三 */
    [self setUpTitleColor:^(BOOL *isShowTitleGradient, YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *startColor, UIColor *__autoreleasing *endColor) {
        
        // 标题渐变
        *isShowTitleGradient = YES;

        // 标题填充模式
        *titleColorGradientStyle = YZTitleColorGradientStyleFill;

        *startColor = [UIColor blackColor];
        *endColor = [UIColor orangeColor];
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.selectIndex = 2;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 段子
    ChildViewController *wordVc1 = [[ChildViewController alloc] init];
    wordVc1.title = @"小码哥";
    [self addChildViewController:wordVc1];
    
    // 段子
    ChildViewController *wordVc2 = [[ChildViewController alloc] init];
    wordVc2.title = @"M了个J";
    [self addChildViewController:wordVc2];
    
    // 段子
    ChildViewController *wordVc3 = [[ChildViewController alloc] init];
    wordVc3.title = @"啊峥";
    [self addChildViewController:wordVc3];
    
    ChildViewController *wordVc4 = [[ChildViewController alloc] init];
    wordVc4.title = @"吖了个峥";
    [self addChildViewController:wordVc4];
    
    // 全部
    ChildViewController *allVc = [[ChildViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    // 视频
    ChildViewController *videoVc = [[ChildViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 声音
    ChildViewController *voiceVc = [[ChildViewController alloc] init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    // 图片
    ChildViewController *pictureVc = [[ChildViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    // 段子
    ChildViewController *wordVc = [[ChildViewController alloc] init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
    
   
    
}


@end
