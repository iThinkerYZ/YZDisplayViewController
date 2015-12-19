//
//  YZDisplayViewController.h
//  BuDeJie
//
//  Created by yz on 15/12/1.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>


// 颜色渐变样式
typedef enum : NSUInteger {
    YZTitleColorGradientStyleRGB,
    YZTitleColorGradientStyleFill,
} YZTitleColorGradientStyle;

/*
    使用注意：
    1.字体放大效果和角标不能同时使用。
    2.网易效果：颜色渐变 + 字体缩放
    3.进入头条效果：颜色填充渐变
    4.展示tableView的时候，如果有UITabBarController,UINavgationController,需要自己给tableView添加额外滚动区域。
 
 */

@interface YZDisplayViewController : UIViewController

/**************************************内容************************************/
/*
    内容是否需要全屏展示
    YES :  全屏：内容占据整个屏幕，会有穿透导航栏效果，需要手动设置tableView额外滚动区域
    NO  :  内容从标题下展示
 */
@property (nonatomic, assign) BOOL isfullScreen;

/**************************************内容************************************/



/**************************************标题************************************/


/*
 标题滚动视图背景颜色
 */
@property (nonatomic, strong) UIColor *titleScrollViewColor;


/*
    标题高度
 */
@property (nonatomic, assign) CGFloat titleHeight;

/*
    正常标题颜色
 */
@property (nonatomic, strong) UIColor *norColor;

/*
    选中标题颜色
 */
@property (nonatomic, strong) UIColor *selColor;

/*
    标题字体
 */
@property (nonatomic, strong) UIFont *titleFont;


/**************************************标题************************************/






/**************************************下标************************************/

/*
    是否需要下标
 */
@property (nonatomic, assign) BOOL isShowUnderLine;


/*
    是否延迟滚动下标
 */
@property (nonatomic, assign) BOOL isDelayScroll;
/*
    下标颜色
 */
@property (nonatomic, strong) UIColor *underLineColor;

/*
    下标高度
 */
@property (nonatomic, assign) CGFloat underLineH;

/**************************************下标************************************/





/**********************************字体缩放************************************/
/*
    字体放大
 */
@property (nonatomic, assign) BOOL isShowTitleScale;

/*
    字体缩放比例
 */
@property (nonatomic, assign) CGFloat titleScale;

/**********************************字体缩放************************************/




/**********************************颜色渐变************************************/

/*
    字体是否渐变
 */
@property (nonatomic, assign) BOOL isShowTitleGradient;

/*
    颜色渐变样式
*/
@property (nonatomic, assign) YZTitleColorGradientStyle titleColorGradientStyle;

/*
开始颜色,取值范围0~1
*/
@property (nonatomic, assign) CGFloat startR;

@property (nonatomic, assign) CGFloat startG;

@property (nonatomic, assign) CGFloat startB;

/*
 完成颜色,取值范围0~1
*/
@property (nonatomic, assign) CGFloat endR;

@property (nonatomic, assign) CGFloat endG;

@property (nonatomic, assign) CGFloat endB;

/**********************************颜色渐变************************************/

/**********************************遮盖************************************/

/*
    是否显示遮盖
 */
@property (nonatomic, assign) BOOL isShowTitleCover;

/*
    遮盖颜色
 */
@property (nonatomic, strong) UIColor *coverColor;

/*
    遮盖圆角半径
 */
@property (nonatomic, assign) CGFloat coverCornerRadius;

/**********************************遮盖************************************/



/*
    刷新标题和整个界面，在调用之前，必须先确定所有的子控制器。
 */
- (void)refreshDisplay;


@end
