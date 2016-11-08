//
//  NSObject+frameExtension.h
//  WaiKaInternetion
//
//  Created by Mac on 16/4/30.
//  Copyright © 2016年 com.WaiKa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIView (frameExtension)

@property (nonatomic, assign) CGFloat wg_x;
@property (nonatomic, assign) CGFloat wg_y;
@property (nonatomic, assign) CGSize  wg_size;
@property (nonatomic, assign) CGFloat wg_width;
@property (nonatomic, assign) CGFloat wg_height;
@property (nonatomic, assign) CGFloat wg_centerX;
@property (nonatomic, assign) CGFloat wg_centerY;
@property (assign,nonatomic)  CGPoint wg_center;
// 设置圆角
- (void)setCorner:(CGFloat)corner;

// 动态添加属性
- (NSMutableDictionary *)getRuntimeProperty;

- (void)setRuntimePropertyWithValue:(id)value forKey:(NSString *)key;


@end
