//
//  YZTXViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZTXViewController.h"

#import "ChildViewController.h"

@implementation YZTXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat y = self.navigationController?64:0;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 设置搜索框
    CGFloat searchH = 44;
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, y, screenW, searchH)];
    
    [self.view addSubview:searchBar];

    
    // 设置整体内容尺寸（包含标题滚动视图和底部内容滚动视图）
    [self setUpContentViewFrame:^(UIView *contentView) {
       
        CGFloat contentX = 0;
        
        CGFloat contentY = CGRectGetMaxY(searchBar.frame);
        
        CGFloat contentH = screenH - contentY;

        contentView.frame = CGRectMake(contentX, contentY, screenW, contentH);
        
    }];
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    /****** 标题渐变 ******/
    /*
            方式一
    self.isShowTitleGradient = YES;
    self.endR = 1;
    self.endG = 130 / 255.0;
    self.endB = 44 / 255.0;
    */
    
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(BOOL *isShowTitleGradient, YZTitleColorGradientStyle *titleColorGradientStyle, CGFloat *startR, CGFloat *startG, CGFloat *startB, CGFloat *endR, CGFloat *endG, CGFloat *endB) {
        
        // 不需要设置的属性，可以不管
        *isShowTitleGradient = YES;
        *endR = 1;
        *endG = 130 / 255.0;
        *endB = 44 / 255.0;
        
    }];
    
    
    /****** 设置遮盖 ******/
//    self.isShowTitleCover = YES;
//    self.coverColor = [UIColor colorWithWhite:0.7 alpha:0.4];
//    self.coverCornerRadius = 13;
    
    // *推荐方式(设置遮盖)
    [self setUpCoverEffect:^(BOOL *isShowTitleCover, UIColor **coverColor, CGFloat *coverCornerRadius) {
        // 设置是否显示标题蒙版
        *isShowTitleCover = YES;
        
        // 设置蒙版颜色
        *coverColor = [UIColor colorWithWhite:0.7 alpha:0.4];
        
        // 设置蒙版圆角半径
        *coverCornerRadius = 13;
    }];
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
