//
//  WGAlertView.m
//  WGAlertView
//
//  Created by Alex William on 2016/11/8.
//  Copyright © 2016年 WaiKa. All rights reserved.
//

#import "WGAlertView.h"

typedef void(^animateBlock)();

@interface WGAlertView()
{

    UIView *contentView;
    
    UIView *bgView;
    
    UIImageView *headView;
    
    UILabel *titleLb, *msgLb;
    
    UIButton *fixedBtn, *cancleBtn;
    
    NSMutableArray *_animateArr;
    
    CGFloat kcontentW;
    CGFloat headW;
}

@end

@implementation WGAlertView

// 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //default values
        _tintColor = GREENCOLOR;
        
        _animateArr = @[].mutableCopy;
        
        _headImage = [UIImage imageNamed:@"Icon-180"];
        
        kcontentW=(WGScreenWidth*0.8);
        
        headW=80;
        
        self.frame=[[UIScreen mainScreen]bounds];
        
        
        //add blur effect view
        UIView* bgV =nil;
        
        if([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
            bgV = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
            
        }else{
            UIToolbar *toolBar = [[UIToolbar alloc]init];
            toolBar.barStyle = UIBarStyleBlackOpaque;
            bgV = toolBar;
        }
        
        bgV.frame=self.frame;
        [self addSubview:bgV];
        bgV.userInteractionEnabled=YES;
        UITapGestureRecognizer* tapBg=[[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(bgTap)];
        [bgV addGestureRecognizer:tapBg];
        bgView=bgV;
        
        
        UIView *contentV=[UIView new];
        contentV.backgroundColor=[UIColor whiteColor];
        [self addSubview: contentV];
        contentV.layer.cornerRadius=5;
        contentView=contentV;
        
        
        UILabel* tLb = [[UILabel alloc]init];
        tLb.textColor=[UIColor blackColor];
        tLb.font= [UIFont systemFontOfSize:18];
        tLb.numberOfLines=0;
        tLb.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:tLb];
        titleLb = tLb;
        
        UILabel* dLb = [[UILabel alloc]init];
        dLb.textColor=[UIColor blackColor];
        dLb.font= [UIFont systemFontOfSize:15];
        dLb.numberOfLines=0;
        dLb.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:dLb];
        msgLb = dLb;
        
        
        UIButton *fixed  = [[UIButton alloc]init];
        fixed.backgroundColor = self.tintColor;
        [fixed setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [fixed setTitle:@"sure" forState:UIControlStateNormal];
        fixed.titleLabel.font=[UIFont systemFontOfSize:15];
        fixed.tag=0;
        [fixed addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [fixed setCorner:5];
        [contentView addSubview:fixed];
        fixedBtn = fixed;
        
        
        UIButton* cancel  = [[UIButton alloc]init];
        cancel.backgroundColor=[UIColor lightGrayColor];
        [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancel setTitle:@"cancel" forState:UIControlStateNormal];
        cancel.titleLabel.font=[UIFont systemFontOfSize:15];
        cancel.tag=1;
        [cancel addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancel setCorner:5];
        [contentView addSubview:cancel];
        cancleBtn = cancel;
        
        
        UIImageView* headV =[UIImageView new];
        [contentView addSubview:headV];
        headView=headV;
        
        //add shadow
        contentView.layer.shadowColor=[UIColor blackColor].CGColor;
        contentView.layer.shadowOffset=CGSizeZero;
        contentView.layer.shadowRadius=20.f;
        contentView.layer.shadowOpacity=0.4f;
    }
    return self;
}


// 弹框内容
+ (instancetype)wgAlertViewWithTitle:(NSString *)title message:(NSString *)message type:(WGAlertType)type mode:(WGAlertShowModel)model fixedTitle:(NSString *)fixed cancleTitle:(NSString *)cancle
{

    WGAlertView* view = [[WGAlertView alloc]init];
    view.type = type;
    view.modle = model;
    view->titleLb.text = title;
    view->msgLb.text = message;
    [view->fixedBtn setTitle:fixed forState:UIControlStateNormal];
    [view->cancleBtn setTitle:cancle forState:UIControlStateNormal];
    return view;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupColorAndImg];

    CGFloat btnW=90,btnH=35,statusBarH=20;
    
    CGFloat titleMarginT=headW/2+5,msgMarginT=10,btnMarginT=15,btnMarginB=10;
    
    CGFloat spaceBtn=20;//space between surebtn and cancelbtn
    
    CGFloat titleH=[self getLbSize:titleLb].height;
    
    CGFloat desH=[self getLbSize:msgLb].height;
    
    
    CGFloat contentH = titleMarginT+titleH+msgMarginT+desH+btnMarginT+btnH+btnMarginB,contentW=kcontentW;
    
    while((contentH+headW+statusBarH*2)>WGScreenHeight) {
        //adjust the height
        if(titleH>desH)titleH-=10;
        else desH-=10;
        
        contentH = titleMarginT+titleH+msgMarginT+desH+btnMarginT+btnH+btnMarginB,contentW=kcontentW;
    }
    contentView.wg_size=CGSizeMake(contentW, contentH);
    contentView.wg_center=self.center;
    
    [headView setCorner:headW/2];
    headView.frame=CGRectMake((contentW-headW)/2, -headW/2, headW, headW);
  
    titleLb.frame=CGRectMake(0, titleMarginT, contentW, titleH);
    msgLb.frame=CGRectMake(0, CGRectGetMaxY(titleLb.frame)+msgMarginT, contentW, desH);
 
    CGFloat btnY=CGRectGetMaxY(msgLb.frame)+btnMarginT ;
    
    if (self.type==WGAlertSuccess||self.type==WGAlertInfo) {
        //show one btn
        fixedBtn.frame=CGRectMake((contentW-btnW*2)/2, btnY, btnW*2, btnH);
        cancleBtn.frame=CGRectZero;
    }
    else{
        //show two btn
        fixedBtn.frame=CGRectMake(contentW/2-btnW-spaceBtn/2, btnY, btnW, btnH);
        cancleBtn.frame=CGRectMake(contentW/2+spaceBtn/2, btnY, btnW, btnH);
    }
}

-(CGSize)getLbSize:(UILabel*)lb{
    return [lb.text boundingRectWithSize:CGSizeMake(kcontentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lb.font} context:nil].size;
}

#pragma mark - Property
-(void)setHeadImg:(UIImage *)headImg{
    _headImage = headImg;
    headView.image=headImg;
}

-(void)setTintColor:(UIColor *)tintColor{
    
    [fixedBtn setBackgroundColor:tintColor];
}

#pragma mark - Animations

-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if (self.willAppear) {
        self.willAppear(self);
    }
    
    if (self.modle == WGAlertShowTypeDrop) {
        
        //step1
        animateBlock drop = ^(){
            
            contentView.center=CGPointMake(WGScreenWidth/2, -WGScreenHeight);
            
            headView.alpha=0;
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                contentView.center=CGPointMake(WGScreenWidth/2, WGScreenHeight/2);
                
            } completion:^(BOOL finished) {
                [self removeAni];
            }];
        };
        
        [_animateArr addObject:drop];
    
        //step2
        animateBlock smaller = ^(){
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                
                headView.alpha=1;
                
                headView.transform=CGAffineTransformMakeScale(0.4, 0.4);
                
            } completion:^(BOOL finished) {
                
                [self removeAni];
            }];
        };
        
        [_animateArr addObject:smaller];

        //step3
        animateBlock bigger = ^(){
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                headView.transform=CGAffineTransformIdentity;
                
            } completion:^(BOOL finished) {
                
                [self removeAni];
                
                if (self.didAppear) {
                    self.didAppear(self);
                }
            }];
        };
        
        [_animateArr addObject:bigger];
    }
    if (self.modle == WGAlertShowTypeFade) {

        animateBlock fadeBG = ^(){
            bgView.alpha=0.5;
            contentView.alpha=0;
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                bgView.alpha=1;
                
            } completion:^(BOOL finished) {
                
                [self removeAni];
            }];
        };
        
        [_animateArr addObject:fadeBG];
        
        animateBlock fade = ^(){
            
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                contentView.alpha=1;
                
            } completion:^(BOOL finished) {
                
                [self removeAni];
                
                if (self.didAppear) {
                    self.didAppear(self);
                }
            }];
        };
        
        [_animateArr addObject:fade];
    }
    
    [self nextAnimate];
}

-(void)nextAnimate{
    
    if (_animateArr.count==0) {
        return;
    }
    animateBlock ani= [_animateArr firstObject];
    ani();
}

-(void)removeAni{
    [_animateArr removeObjectAtIndex:0];
    
    [self nextAnimate];
}

#pragma mark  - user Interaction

-(void)dismiss{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        if (self.willDisappear) {
            self.willDisappear(self);
        }
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.alpha=0;
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            
            if (self.didDisappear) {
                self.didDisappear(self);
            }
        }];
    });
}

-(void)btnClick:(UIButton*)btn{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        switch (btn.tag) {
            case 0://sure
                if (self.fixedClick) {
                    self.fixedClick(self);
                }
                break;
            case 1://cancel
                
                if (self.cancleClick) {
                    self.cancleClick(self);
                }
                break;

            default:
                break;
        }
    });

    [self dismiss];
}

-(void)bgTap{
    
    if (self.backgroundClick) {
        self.backgroundClick(self);
    }
    [self dismiss];
}

-(void)setupColorAndImg{
    
    UIImage* img =nil;
    
    switch (self.type) {
        case WGAlertSuccess:
            img=[self imageWithBgColor:GREENCOLOR logo:[UIImage imageNamed:@"checkMark"]];
            self.tintColor=GREENCOLOR;
            break;
            
        case WGAlertInfo:
            img=[self imageWithBgColor:BLUECOLOR logo:[UIImage imageNamed:@"infoMark"]];
            self.tintColor=BLUECOLOR;
            break;
            
        case WGAlertFaild:
            img=[self imageWithBgColor:REDCOLOR logo:[UIImage imageNamed:@"crossMark"]];
            self.tintColor=REDCOLOR;
            
            break;
        case WGAlertCustom:
            img =self.headImage;
            self.tintColor=REDCOLOR;
            break;
            
        default:
            break;
    }
    
    headView.image=img;
}

-(UIImage*)imageWithBgColor:(UIColor*)color logo:(UIImage*)logoImg{
    if (!color||!logoImg) {
        return  nil;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(headW, headW), NO, 1);
    
    CGContextRef ctx=  UIGraphicsGetCurrentContext();
    
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, headW/2, headW/2, headW/2, 0, M_PI*2, YES);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);

    CGFloat logoW=headW*0.3,logoY=(headW-logoW)/2;
    
    [logoImg drawInRect:CGRectMake(logoY, logoY,logoW,logoW)];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return  img ;
}


@end
