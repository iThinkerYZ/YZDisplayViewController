//
//  UIView+Frame.m
//  BuDeJie
//
//  Created by yz on 15/10/29.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)yz_height
{
    return self.frame.size.height;
}

- (CGFloat)yz_width
{
    return self.frame.size.width;
}

- (void)setYz_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setYz_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)yz_x
{
    return self.frame.origin.x;
}

- (void)setYz_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)yz_y
{
    return self.frame.origin.y;
}

- (void)setYz_y:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setYz_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)yz_centerX
{
    return self.center.x;
}

- (void)setYz_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)yz_centerY
{
    return self.center.y;
}

@end
