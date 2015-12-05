//
//  YZDisplayViewController.m
//  BuDeJie
//
//  Created by yz on 15/12/1.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "YZDisplayViewController.h"

#import "YZDisplayTitleLabel.h"

#import "YZDisplayViewControllerConst.h"

#import "UIView+Frame.h"

@interface YZDisplayViewController ()<UIScrollViewDelegate>

/** 标题滚动视图背景View */
@property (nonatomic, strong) UIImageView *titleScrollViewBackgroundImageView;

/** 标题滚动视图 */
@property (nonatomic, weak) UIScrollView *titleScrollView;

@property (nonatomic, weak) UIScrollView *contentScrollView;

@property (nonatomic, strong) NSMutableArray *titleLabels;

@property (nonatomic, strong) NSMutableArray *titleWidths;

@property (nonatomic, weak) UILabel *selLabel;

@property (nonatomic, weak) UIView *underLine;


// 记录上一次内容滚动视图偏移量
@property (nonatomic, assign) CGFloat lastOffsetX;

// 记录是否点击
@property (nonatomic, assign) BOOL isClickTitle;

// 标题间距
@property (nonatomic, assign) CGFloat titleMargin;


@end

@implementation YZDisplayViewController

- (UIImageView *)titleScrollViewBackgroundImageView
{
    if (_titleScrollViewBackgroundImageView == nil) {
        _titleScrollViewBackgroundImageView = [[UIImageView alloc] init];
    }
    return _titleScrollViewBackgroundImageView;
}

- (NSMutableArray *)titleWidths
{
    if (_titleWidths == nil) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}
- (UIColor *)norColor
{
    if (_isShowTitleGradient && _titleColorGradientStyle == YZTitleColorGradientStyleRGB) {
         _norColor = [UIColor colorWithRed:_startR green:_startG blue:_startB alpha:1];
    }
    
    if (_norColor == nil){
        _norColor = [UIColor blackColor];
    }
    
    
    return _norColor;
}

- (UIColor *)selColor
{
    if (_isShowTitleGradient && _titleColorGradientStyle == YZTitleColorGradientStyleRGB) {
        _selColor = [UIColor colorWithRed:_endR green:_endG blue:_endB alpha:1];
    }
    
    if (_selColor == nil) _selColor = [UIColor redColor];
    
    return _selColor;
}

- (void)setIsShowTitleScale:(BOOL)isShowTitleScale
{
    if (_isShowUnderLine) {
        // 抛异常
        NSException *excp = [NSException exceptionWithName:@"YZDisplayViewControllerException" reason:@"字体放大效果和角标不能同时使用。" userInfo:nil];
        [excp raise];
    }
    
    _isShowTitleScale = isShowTitleScale;
}

- (void)setIsShowUnderLine:(BOOL)isShowUnderLine
{
    if (_isShowTitleScale) {
        // 抛异常
        NSException *excp = [NSException exceptionWithName:@"YZDisplayViewControllerException" reason:@"字体放大效果和角标不能同时使用。" userInfo:nil];
        [excp raise];
    }
    
    _isShowUnderLine = isShowUnderLine;
}

- (UIView *)underLine
{
    if (_underLine == nil) {
        
        UIView *underLineView = [[UIView alloc] init];
        
        underLineView.backgroundColor = _underLineColor?_underLineColor:[UIColor redColor];
        
        [self.titleScrollView addSubview:underLineView];
        
        _underLine = underLineView;
        
    }
    return _isShowUnderLine?_underLine : nil;
}

- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加顶部标签滚动视图
    [self setUpTitleScrollView];
    
    // 添加底部内容滚动视图
    [self setUpContentScrollView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置内容滚动视图
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.bounces = NO;

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.titleLabels.count) return;
    
    [self setUpTitleWidth];
    
    [self setUpAllTitle];
    
    if (_isShowTitleGradient && _titleColorGradientStyle == YZTitleColorGradientStyleRGB) {
        
        // 初始化颜色渐变
        if (_endR == 0 && _endG == 0 && _endB == 0) {
            _endR = 1;
        }
    }
    
    if (_isfullScreen) {
        // 全屏展示
        _contentScrollView.frame = CGRectMake(0, 0, YZScreenW, YZScreenH);
    }

    
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取左边角标
    NSInteger leftIndex = offsetX / YZScreenW;
    
    // 左边按钮
    YZDisplayTitleLabel *leftLabel = self.titleLabels[leftIndex];
    
    // 右边角标
    NSInteger rightIndex = leftIndex + 1;
    
    // 右边按钮
    YZDisplayTitleLabel *rightLabel = nil;
    
    if (rightIndex < self.titleLabels.count) {
        rightLabel = self.titleLabels[rightIndex];
    }
    
    // 字体放大
    [self setUpTitleSaceWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 设置角标偏移
    [self setUpUnderLineOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 设置标题渐变
    [self setUpTitleColorGradientWithOffset:offsetX rightLabel:rightLabel leftLabel:leftLabel];
    
    // 记录上一次的偏移量
    _lastOffsetX = offsetX;
}

// 设置标题颜色渐变
- (void)setUpTitleColorGradientWithOffset:(CGFloat)offsetX rightLabel:(YZDisplayTitleLabel *)rightLabel leftLabel:(YZDisplayTitleLabel *)leftLabel
{
    if (_isShowTitleGradient == NO) return;
    
    // 获取右边缩放
    CGFloat rightSacle = offsetX / YZScreenW - leftLabel.tag;
    
    // 获取左边缩放比例
    CGFloat leftScale = 1 - rightSacle;
    
    // RGB渐变
    if (_titleColorGradientStyle == YZTitleColorGradientStyleRGB) {
        
        
        CGFloat r = _endR - _startR;
        CGFloat g = _endG - _startG;
        CGFloat b = _endB - _startB;
        
        // rightColor
        // 1 0 0
        UIColor *rightColor = [UIColor colorWithRed:_startR + r * rightSacle green:_startG + g * rightSacle blue:_startB + b * rightSacle alpha:1];
        
        // 0.3 0 0
        // 1 -> 0.3
        // leftColor
        UIColor *leftColor = [UIColor colorWithRed:_startR +  r * leftScale  green:_startG +  g * leftScale  blue:_startB +  b * leftScale alpha:1];
        
        // 右边颜色
        rightLabel.textColor = rightColor;
        
        // 左边颜色
        leftLabel.textColor = leftColor;
        
        return;
    }
    
    // 填充渐变
    if (_titleColorGradientStyle == YZTitleColorGradientStyleFill) {
        
        
        
        // 获取移动距离
        CGFloat offsetDelta = offsetX - _lastOffsetX;
        
        if (offsetDelta > 0) { // 往右边
            
            
            rightLabel.fillColor = self.selColor;
            rightLabel.progress = rightSacle;
            
            leftLabel.fillColor = self.norColor;
            leftLabel.progress = rightSacle;
            
        }else if(offsetDelta < 0){ // 往左边

            rightLabel.textColor = self.norColor;
            rightLabel.fillColor = self.selColor;
            rightLabel.progress = rightSacle;
            
            
            leftLabel.textColor = self.selColor;
            leftLabel.fillColor = self.norColor;
            leftLabel.progress = rightSacle;
            
        }
        
        
        
    }
    
    
    
    
    
}

// 标题缩放
- (void)setUpTitleSaceWithOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    if (_isShowTitleScale == NO) return;
    
    // 获取右边缩放
    CGFloat rightSacle = offsetX / YZScreenW - leftLabel.tag;
    
    CGFloat leftScale = 1 - rightSacle;
    
    CGFloat scaleTransform = _titleScale?_titleScale:YZTitleTransformScale;
    
    scaleTransform -= 1;
    
    // 缩放按钮
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * scaleTransform + 1, leftScale * scaleTransform + 1);
    
    // 1 ~ 1.3
    rightLabel.transform = CGAffineTransformMakeScale(rightSacle * scaleTransform + 1, rightSacle * scaleTransform + 1);
}


// 获取两个标题按钮宽度差值
- (CGFloat)widthDeltaWithRightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    CGRect titleBoundsR = [rightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YZTitleFont} context:nil];
    
    CGRect titleBoundsL = [leftLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YZTitleFont} context:nil];
    
    return titleBoundsR.size.width - titleBoundsL.size.width;
}


// 设置角标偏移
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel
{
    // 点击的时候不需要设置
    if (_isClickTitle) return;
    
    // 获取两个标题中心点距离
    CGFloat centerDelta = rightLabel.center.x - leftLabel.center.x;
    
    // 标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLabel:rightLabel leftLabel:leftLabel];
    
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    
    // 计算当前下划线偏移量
    CGFloat underLineTransformX = offsetDelta * centerDelta / YZScreenW;
    
    // 宽度递增偏移量
    CGFloat underLineWidth = offsetDelta * widthDelta / YZScreenW;
    
    self.underLine.width += underLineWidth;
    self.underLine.x += underLineTransformX;
    
    

}

// 减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    CGFloat offsetX = scrollView.contentOffset.x;
    // 获取角标
    NSInteger i = offsetX / YZScreenW;
    
    // 选中标题
    [self selectLabel:self.titleLabels[i]];
    
    // 添加控制器的view
    [self setUpVc:i];
    
}




// 标题按钮点击
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    // 记录是否点击标题
    _isClickTitle = YES;
    
    // 获取对应标题label
    UILabel *label = (UILabel *)tap.view;
    
    // 获取当前角标
    NSInteger i = label.tag;
    
    // 选中label
    [self selectLabel:label];
    
    // 内容滚动视图滚动到对应位置
    CGFloat offsetX = i * YZScreenW;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    // 记录上一次偏移量,因为点击的时候不会调用scrollView代理记录，因此需要主动记录
    _lastOffsetX = offsetX;
    
    // 添加对应的控制器view在对应位置上
    [self setUpVc:i];
    
   
    // 点击事件处理完成
    _isClickTitle = NO;
}

- (void)setUpVc:(NSInteger)i
{
    
    UIViewController *vc = self.childViewControllers[i];
    
    if (vc.viewIfLoaded) return;
    
    vc.view.frame = self.contentScrollView.bounds;
    [self.contentScrollView addSubview:vc.view];
}


- (void)selectLabel:(UILabel *)label
{
    
    // 标题缩放
    if (_isShowTitleScale) {
        
        CGFloat scaleTransform = _titleScale?_titleScale:YZTitleTransformScale;
        
        _selLabel.transform = CGAffineTransformIdentity;
        
        label.transform = CGAffineTransformMakeScale(scaleTransform, scaleTransform);
    }
    
    
    _selLabel.textColor = self.norColor;
    
    // 修改标题选中颜色
    label.textColor = self.selColor;
    
    _selLabel = label;
    
    // 设置标题居中
    [self setLabelTitleCenter:label];
    
    // 设置下标的位置
    [self setUpUnderLine:label];
    
}

// 设置下标的位置
- (void)setUpUnderLine:(UILabel *)label
{
    // 获取文字尺寸
    CGRect titleBounds = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YZTitleFont} context:nil];
    
    CGFloat underLineH = _underLineH?_underLineH:YZUnderLineH;
    
    self.underLine.y = label.height - underLineH;
    self.underLine.height = underLineH;

    
    // 最开始不需要动画
    if (self.underLine.x == 0) {
        self.underLine.width = titleBounds.size.width;
        
        self.underLine.x = label.center.x - self.underLine.width * 0.5;
        return;
    }
    
    // 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.width = titleBounds.size.width;
        self.underLine.x = label.center.x - self.underLine.width * 0.5;
    }];
    
}

// 让选中的按钮居中显示
- (void)setLabelTitleCenter:(UILabel *)label
{
    
    // 设置标题滚动区域的偏移量
    CGFloat offsetX = label.center.x - YZScreenW * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    // 计算下最大的标题视图滚动区域
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - YZScreenW;
    
    if (maxOffsetX < 0) {
        maxOffsetX = 0;
    }
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    // 滚动区域
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}


// 计算标题宽度
- (void)setUpTitleWidth
{
    // 判断是否能占据整个屏幕
    NSUInteger count = self.childViewControllers.count;
    
    NSArray *titles = [self.childViewControllers valueForKeyPath:@"title"];
    
    CGFloat totalWidth = 0;
    
    // 计算所有标题的宽度
    for (NSString *title in titles) {
         CGRect titleBounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:YZTitleFont} context:nil];
        
        CGFloat width = titleBounds.size.width;
        
        [self.titleWidths addObject:@(width)];
        
        totalWidth += width;
    }
    
    if (totalWidth > YZScreenW) {
        
        _titleMargin = margin;
        
        return;
    }
    
    CGFloat titleMargin = (YZScreenW - totalWidth) / (count + 1);
    
    _titleMargin = titleMargin < margin? margin: titleMargin;
}

// 设置所有标题
- (void)setUpAllTitle
{
    
    // 遍历所有的子控制器
    NSUInteger count = self.childViewControllers.count;
    
    // 添加所有的标题
    
    CGFloat labelW = 0;
    CGFloat labelH = YZTitleScrollViewH;
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    for (int i = 0; i < count; i++) {
        
        UIViewController *vc = self.childViewControllers[i];
        
        UILabel *label = [[YZDisplayTitleLabel alloc] init];
        
        label.tag = i;
        
        // 设置按钮的文字颜色
        label.textColor = self.norColor;

        label.font = _titleFont?_titleFont: YZTitleFont;
        
        // 设置按钮标题
        label.text = vc.title;

        labelW = [self.titleWidths[i] floatValue];
        
        // 设置按钮位置
        UILabel *lastLabel = [self.titleLabels lastObject];
        
        labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 监听标题的点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        if (i == 0) {
            [self titleClick:tap];
        }
        
        // 保存到数组
        [self.titleLabels addObject:label];
        
        [_titleScrollView addSubview:label];
    }
    
    // 设置标题滚动视图的内容范围
    UILabel *lastLabel = self.titleLabels.lastObject;
    _titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    _titleScrollView.showsHorizontalScrollIndicator = NO;

    _contentScrollView.contentSize = CGSizeMake(count * YZScreenW, 0);
    
}

// 设置背景图片
- (void)setTitleScrollViewBackgroundImage:(UIImage *)titleScrollViewBackgroundImage
{
    _titleScrollViewBackgroundImage = titleScrollViewBackgroundImage;
    self.titleScrollViewBackgroundImageView.image = titleScrollViewBackgroundImage;
    self.titleScrollViewBackgroundImageView.frame = _titleScrollView.bounds;
    [_titleScrollView insertSubview:self.titleScrollViewBackgroundImageView atIndex:0];
}

// 1.添加标题滚动视图
- (void)setUpTitleScrollView
{
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    
    titleScrollView.backgroundColor = _titleScrollViewColor?_titleScrollViewColor:[UIColor colorWithWhite:1 alpha:0.7];
    
    // 计算尺寸
    CGFloat y = self.navigationController?YZNavBarH : 0;
    
    CGFloat titleH = _titleHeight?_titleHeight:YZTitleScrollViewH;
    titleScrollView.frame = CGRectMake(0, y, YZScreenW, titleH);
    
    [self.view addSubview:titleScrollView];
    
    _titleScrollView = titleScrollView;
}

// 2.添加内容滚动视图
- (void)setUpContentScrollView
{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    
    // 计算尺寸
    CGFloat y = CGRectGetMaxY(_titleScrollView.frame);
    
    contentScrollView.frame = CGRectMake(0, y, YZScreenW, YZScreenH - y);
    
    
    [self.view insertSubview:contentScrollView belowSubview:_titleScrollView];
    
    _contentScrollView = contentScrollView;
    
    _contentScrollView.delegate = self;
    
}


@end
