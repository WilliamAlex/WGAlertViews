//
//  NSObject+frameExtension.m
//  WaiKaInternetion
//
//  Created by Mac on 16/4/30.
//  Copyright © 2016年 com.WaiKa. All rights reserved.
//

#import "NSObject+frameExtension.h"
#import <objc/message.h>

static char kUIViewRuntimeProperty;
@implementation UIView (frameExtension)

- (void)setWg_size:(CGSize)wg_size
{
    CGRect frame = self.frame;
    frame.size = wg_size;
    self.frame = frame;
}

- (CGSize)wg_size
{
    return self.frame.size;
}

- (void)setWg_width:(CGFloat)wg_width
{
    CGRect frame = self.frame;
    frame.size.width = wg_width;
    self.frame = frame;
}

- (void)setWg_height:(CGFloat)wg_height
{
    CGRect frame = self.frame;
    frame.size.height = wg_height;
    self.frame = frame;
}

- (void)setWg_x:(CGFloat)wg_x
{
    CGRect frame = self.frame;
    frame.origin.x = wg_x;
    self.frame = frame;
}
- (void)setWg_y:(CGFloat)wg_y
{
    CGRect frame = self.frame;
    frame.origin.y = wg_y;
    self.frame = frame;
}

- (void)setWg_centerX:(CGFloat)wg_centerX
{
    CGPoint center = self.center;
    center.x = wg_centerX;
    self.center = center;
}

- (void)setWg_centerY:(CGFloat)wg_centerY
{
    CGPoint center = self.center;
    center.y = wg_centerY;
    self.center = center;
}

- (CGFloat)wg_centerY
{
    return self.center.y;
}

- (CGFloat)wg_centerX
{
    return self.center.x;
}

- (CGFloat)wg_width
{
    return self.frame.size.width;
}

- (CGFloat)wg_height
{
    return self.frame.size.height;
}

- (CGFloat)wg_x
{
    return self.frame.origin.x;
}

- (CGFloat)wg_y
{
    return self.frame.origin.y;
}
-(void)setWg_center:(CGPoint)center{
    self.center=center;
}
-(CGPoint)wg_center{
    return self.center;
}



- (void)setCorner:(CGFloat)corner
{
    self.layer.cornerRadius = corner;
    self.layer.masksToBounds = YES;
}

-(NSMutableDictionary*)getRuntimeProperty{
    NSMutableDictionary*dic=objc_getAssociatedObject(self, &kUIViewRuntimeProperty);
    if (dic) {
        return dic;
    }
    dic =  @{}.mutableCopy;
    objc_setAssociatedObject(self, &kUIViewRuntimeProperty, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return  dic;
}


-(void)setRuntimePropertyWithValue:(id)value forKey:(NSString *)key{
    NSMutableDictionary* dic = [self getRuntimeProperty];
    [dic setObject:value forKey:key];
}


































@end
