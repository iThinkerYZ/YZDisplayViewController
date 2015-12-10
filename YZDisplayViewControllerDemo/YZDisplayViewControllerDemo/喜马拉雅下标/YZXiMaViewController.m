//
//  YZXiMaViewController.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZXiMaViewController.h"

#import "ChildViewController.h"

#import "FullChildViewController.h"

@implementation YZXiMaViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加所有子控制器
    [self setUpAllViewController];
    
    self.titleFont = [UIFont systemFontOfSize:20];
    
    // 是否显示标签
    self.isShowUnderLine = YES;
    
    // 标题填充模式
    self.underLineColor = [UIColor redColor];
    
    // 设置全屏显示
    // 如果有导航控制器或者tabBarController,需要设置tableView额外滚动区域,详情请看FullChildViewController
    self.isfullScreen = YES;
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    // 段子
    FullChildViewController *wordVc1 = [[FullChildViewController alloc] init];
    wordVc1.title = @"小码哥";
    [self addChildViewController:wordVc1];
    
    // 段子
    FullChildViewController *wordVc2 = [[FullChildViewController alloc] init];
    wordVc2.title = @"M了个J";
    [self addChildViewController:wordVc2];
    
    // 段子
    FullChildViewController *wordVc3 = [[FullChildViewController alloc] init];
    wordVc3.title = @"啊峥";
    [self addChildViewController:wordVc3];
    
    FullChildViewController *wordVc4 = [[FullChildViewController alloc] init];
    wordVc4.title = @"吖了个峥";
    [self addChildViewController:wordVc4];
    
    // 全部
    FullChildViewController *allVc = [[FullChildViewController alloc] init];
    allVc.title = @"全部";
    [self addChildViewController:allVc];
    
    // 视频
    FullChildViewController *videoVc = [[FullChildViewController alloc] init];
    videoVc.title = @"视频";
    [self addChildViewController:videoVc];
    
    // 声音
    ChildViewController *voiceVc = [[ChildViewController alloc] init];
    voiceVc.title = @"声音";
    [self addChildViewController:voiceVc];
    
    // 图片
    FullChildViewController *pictureVc = [[FullChildViewController alloc] init];
    pictureVc.title = @"图片";
    [self addChildViewController:pictureVc];
    
    // 段子
    FullChildViewController *wordVc = [[FullChildViewController alloc] init];
    wordVc.title = @"段子";
    [self addChildViewController:wordVc];
    
    
    
}


@end
