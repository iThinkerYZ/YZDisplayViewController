//
//  RequesCover.m
//  YZDisplayViewControllerDemo
//
//  Created by yz on 15/12/21.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RequesCover.h"

@interface RequesCover ()
@property (weak, nonatomic) IBOutlet UIImageView *animView;

@end

@implementation RequesCover


+ (instancetype)requestCover
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
//    NSMutableArray *images = [NSMutableArray array];
//    for (int i = 1; i <= 10; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"%d",i];
//        UIImage *image = [UIImage imageNamed:imageName];
//        [images addObject:image];
//    }
//    
//    _animView.animationRepeatCount = MAXFLOAT;
//    _animView.animationImages = images;
//    _animView.animationDuration = 1;
//    [_animView startAnimating];
}

@end
