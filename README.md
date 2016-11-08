# WGAlertViews
调用方式:
```objc
    NSString* title=@"登陆成功",*msg=@"登陆成功了啦", *fixed=@"确定啦" , *cancel=@"取消吧";;
    WGAlertView *alertView= [WGAlertView wgAlertViewWithTitle:title message:msg type:WGAlertCustom mode:WGAlertShowTypeFade fixedTitle:fixed cancleTitle:cancel];
    alertView.headImage = [UIImage imageNamed:@"head1.jpeg"];
    
 //  点击事件
    self.alertView.fixedClick = ^(WGAlertView *av) {
    
        WGLog(@"sure clicked");
    };
    self.alertView.cancleClick=^(WGAlertView* av){
        WGLog(@"cancel clicked");
    };
    self.alertView.backgroundClick=^(WGAlertView* av){
        WGLog(@"bg clicked");
    };

    // 生命周期
//    self.alertView.willAppear=^(WGAlertView* av){
//        WGLog(@"willAppear");
//    };
//    self.alertView.didAppear=^(WGAlertView* av){
//        WGLog(@"didAppear");
//    };
//    self.alertView.willDisappear=^(WGAlertView* av){
//        WGLog(@"willDisappear");
//    };
//    self.alertView.didDisappear=^(WGAlertView* av){
//        
//        WGLog(@"didDisappear");
//    };
    [self.alertView show];
```


