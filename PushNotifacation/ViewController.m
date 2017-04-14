//
//  ViewController.m
//  PushNotifacation
//
//  Created by ma c on 16/6/8.
//  Copyright © 2016年 gdd. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myMessWithLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self mySetDatailMess];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backgroundMessOpeartion) name:@"bgckMess" object:nil];
}
#pragma mark 发送通知操作
- (IBAction)sendNotifaAction:(UIButton *)sender {
    UILocalNotification *localNotifa=[[UILocalNotification alloc]init];
    
    localNotifa.alertBody=@"重大消息:微软把诺基亚品牌卖给了富士康!"; // 通知的内容
    localNotifa.soundName=@"buyao.wav"; //通知的声音
    localNotifa.alertAction=@":查看最新重大新闻"; // 锁屏的时候 相当于 滑动来::查看最新重大新闻
//    localNotifa.alertTitle=@"弹出标题,我在这里";
    localNotifa.applicationIconBadgeNumber=3;
    localNotifa.fireDate=[NSDate dateWithTimeIntervalSinceNow:5.0]; // 触发通知的时间(5秒后发送通知)
    localNotifa.timeZone=[NSTimeZone defaultTimeZone];  // 设置时区
    localNotifa.repeatInterval=NSCalendarUnitDay; // 通知重复提示的单位，可以是天、周、月
    
    localNotifa.userInfo=@{@"detailMess":@"在移动业务一直没有起色的情况下,微软又要有所动作了,不过这次受害的不是Windows Phone,而是一直多灾多难的诺基亚。"};
    
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotifa]; // 调度通知(启动通知)
}
#pragma mark 通知设置值
-(void)backgroundMessOpeartion{
    [self mySetDatailMess];
}
-(void)mySetDatailMess{
    AppDelegate *appdele=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myMessWithLabel.text=appdele.myMess;
}
@end
