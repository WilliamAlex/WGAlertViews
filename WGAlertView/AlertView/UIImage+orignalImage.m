//
//  UIImage+orignalImage.m
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/10/30.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import "UIImage+orignalImage.h"

@implementation UIImage (orignalImage)

- (UIImage *)circleImage {
    
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将原照片画到图形上下文
    [self drawInRect:rect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  获取到一张带边框的圆形图片
 */
+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image
{
    // 1.开启一个和原始图片一样大小的位图上下文.
    CGSize size = CGSizeMake(image.size.width + 2 *borderW, image.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size,NO,0);
    // 2.绘制一个大圆,填充
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    // 3.添加一个裁剪区域.
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    [path addClip];
    // 4.把图片绘制到裁剪区域当中.
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    // 5.生成一张新图片.
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    // 6.关闭上下文.
    UIGraphicsEndImageContext();
    return clipImage;
}


@end
