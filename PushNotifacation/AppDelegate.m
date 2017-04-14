//
//  AppDelegate.m
//  PushNotifacation
//
//  Created by ma c on 16/6/8.
//  Copyright © 2016年 gdd. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerNotifa]; // 注册通知
    
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) { // 用户通过通知(App未运行,已经杀死)打开程序,这里通过 Badge 就可以观察到
        application.applicationIconBadgeNumber=10;
        UILocalNotification *myLocalNotifa=launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]; // 返回的是本地通知的对象
        NSDictionary *dicValue=myLocalNotifa.userInfo;
        NSString *detailMess=dicValue[@"detailMess"];
        self.myMess=[NSString stringWithFormat:@"%@(通过通知(App未运行,已经杀死)打开程序,这里是具体的通知信息详情)",detailMess];
    }
    else{  // 用户通过App的图片打开的程序
        NSLog(@"用户通过App的图标打开程序");
        application.applicationIconBadgeNumber=0;
    
    }
    return YES;
}
#pragma mark 注册用户通知
-(void)registerNotifa{
    // 因为这里系统大于IOS 8.0,所有不需要考虑IOS 8.0 以下
    
    UIUserNotificationType notifaType=UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge;
    UIUserNotificationSettings *userNotifi=[UIUserNotificationSettings settingsForTypes:notifaType categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotifi];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}
#pragma mark -通知有关的代理方法
/** App在后台,程序未被杀死,用户点击了本地通知后的操作 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    // 一定要判断App是否在后台
    if (!(application.applicationState==UIApplicationStateActive)) { // App在后台且用户点击了通知后的操作)
        application.applicationIconBadgeNumber=0;
        NSString *strValue=notification.userInfo[@"detailMess"]; // 这里的 userInfo 对应通知的设置信息 userInfo
        self.myMess=[NSString stringWithFormat:@"%@(App在后台且用户点击了通知后,这里是具体的通知信息详情)",strValue];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"bgckMess" object:nil userInfo:nil];
        NSLog(@"App还在后台,点击了本地通知后,进入这个方法.得到的本地其他信息:%@",notification.userInfo);
    }
    else{
        NSLog(@"App在前台,不用做任何操作");
    }
}



#pragma mark -其他代理方法
- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
