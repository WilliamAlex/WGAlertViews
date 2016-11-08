//
//  WGAlertView.h
//  WGAlertView
//
//  Created by Alex William on 2016/11/8.
//  Copyright © 2016年 WaiKa. All rights reserved.
//

#import <UIKit/UIKit.h>

/**弹框类型*/
typedef NS_ENUM(NSInteger, WGAlertType) {

    WGAlertSuccess = 0,   // 成功提示框
    WGAlertFaild,         // 失败提示框
    WGAlertInfo,          // 信息提示框
    WGAlertCustom         // 自定义提示
};

/**弹框出现时的样式*/
typedef NS_ENUM(NSInteger, WGAlertShowModel) {

    WGAlertShowTypeDrop = 0,     // 下拉出现
    WGAlertShowTypeFade          // 渐变出现
};

@interface WGAlertView : UIView

// 整体的一个色调
@property (nonatomic, weak) UIColor *tintColor;

// 自定义头像
@property (nonatomic, strong) UIImage *headImage;

@property (nonatomic, assign) WGAlertType type;
@property (nonatomic, assign) WGAlertShowModel modle;

// 成功与失败的回调
@property (nonatomic, copy) void(^cancleClick)(WGAlertView *view);
@property (nonatomic, copy) void(^fixedClick)(WGAlertView *view);

// 背景View点击的回调
@property (nonatomic, copy) void(^backgroundClick)(WGAlertView *view);

// 弹框的生命周期回调
@property (nonatomic, copy) void(^willAppear)(WGAlertView *view);
@property (nonatomic, copy) void(^didAppear)(WGAlertView *view);
@property (nonatomic, copy) void(^willDisappear)(WGAlertView *view);
@property (nonatomic, copy) void(^didDisappear)(WGAlertView *view);


/**
 *   弹框样式
 *
 *  title: 弹框标题
 *  message: 弹框样式
 *  type: 弹框样式
 *  model: 弹框出现模式
 *  fixed: 确定按钮
 *  cancle: 取消按钮
 */
+ (instancetype)wgAlertViewWithTitle:(NSString *)title message:(NSString *)message type:(WGAlertType)type mode:(WGAlertShowModel)model fixedTitle:(NSString *)fixed cancleTitle:(NSString *)cancle;

/**弹出弹框*/
- (void)show;

@end
