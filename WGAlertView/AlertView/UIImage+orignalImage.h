//
//  UIImage+orignalImage.h
//  BiaoBaiQiang
//
//  Created by Alex William on 2016/10/30.
//  Copyright © 2016年 BiaoBaiQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (orignalImage)


/**生成一张圆角图片*/
- (UIImage *)circleImage;

/**
 *  获取到一张带边框的圆形图片
 *
 *   borderW边框宽度
 *   borderColor:边框颜色
 *   image:要生成的原始图片
 */
+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image;


@end


