
//
//  Const.h
//  BuDeJie
//
//  Created by yz on 15/12/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#ifndef Const_h
#define Const_h

/*
 **************用法*****************
 
 一、导入YZDisplayViewHeader.h
 二、自定义YZDisplayViewController
 三、添加所有子控制器，保存标题在子控制器中
 四、查看YZDisplayViewController头文件，找需要的效果设置
 五、标题被点击或者内容滚动完成，会发出这个通知【"YZDisplayViewClickOrScrollDidFinsh"】，监听这个通知，可以做自己想要做的事情，比如加载数据
 
 **************用法*****************
 */


/*
 使用注意：
 1.字体放大效果和角标不能同时使用。
 2.网易效果：颜色渐变 + 字体缩放
 3.进入头条效果：颜色填充渐变
 4.展示tableView的时候，如果有UITabBarController,UINavgationController,需要自己给tableView添加额外滚动区域。
 */

#import "YZDisplayViewController.h"

// 导航条高度
static CGFloat const YZNavBarH = 64;

// 标题滚动视图的高度
static CGFloat const YZTitleScrollViewH = 44;

// 标题缩放比例
static CGFloat const YZTitleTransformScale = 1.3;

// 下划线默认高度
static CGFloat const YZUnderLineH = 2;

#define YZScreenW [UIScreen mainScreen].bounds.size.width
#define YZScreenH [UIScreen mainScreen].bounds.size.height

// 默认标题字体
#define YZTitleFont [UIFont systemFontOfSize:15]

// 默认标题间距
static CGFloat const margin = 20;

static NSString * const ID = @"cell";

// 标题被点击或者内容滚动完成，会发出这个通知，监听这个通知，可以做自己想要做的事情，比如加载数据
static NSString * const YZDisplayViewClickOrScrollDidFinshNote = @"YZDisplayViewClickOrScrollDidFinshNote";

// 重复点击通知
static NSString * const YZDisplayViewRepeatClickTitleNote = @"YZDisplayViewRepeatClickTitleNote";


#endif /* Const_h */
