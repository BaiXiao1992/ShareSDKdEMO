//
//  AppDelegate.m
//  ShareSDKdEMO
//
//  Created by 白晓 on 2017/2/20.
//  Copyright © 2017年 白晓. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSArray *shareArray = @[@"weibo",@"QQ"/*,@"Wechat"*/];
    [self shareSDK:shareArray shareSDKKey: @"iosv1101" weiboKey:@"568898243" weiboSecret:@"38a4f8204cc784f81f9f0daaf31e02e3" weiboReturnURL:@"http://www.sharesdk.cn" QQID:@"100371282" QQKey:@"aed9b0303e3ed1e27bae87c33761161d" WechatId:@"wx4868b35061f87885" WechatSecret:@"64020361b8ec4c99936c0e3999a9f249"];
    
    self.window.rootViewController = [[RootViewController alloc] init];
    [self.window makeKeyAndVisible];
//    [self shareSDK];
    
    return YES;
}

- (void)shareSDK:(NSArray *)shareArray shareSDKKey:(NSString *)shareSDKKey weiboKey:(NSString *)weiboKey weiboSecret:(NSString *)weiboSecret weiboReturnURL:(NSString *)weiboReturnURL QQID:(NSString *)QQID QQKey:(NSString *)QQKey WechatId:(NSString *)WechatId WechatSecret:(NSString *)WechatSecret{
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */

    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [shareArray count]; i++) {
        if ([[shareArray objectAtIndex:i] isEqualToString:@"weibo"]) {
            [array addObject:@(SSDKPlatformTypeSinaWeibo)];
        }else if ([[shareArray objectAtIndex:i] isEqualToString:@"QQ"]){
            [array addObject:@(SSDKPlatformTypeQQ)];
        }else if ([[shareArray objectAtIndex:i] isEqualToString:@"Wechat"]){
            [array addObject:@(SSDKPlatformTypeWechat)];
        }
    }
    
    [ShareSDK registerApp:shareSDKKey activePlatforms:array onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:weiboKey
                                           appSecret:weiboSecret
                                         redirectUri:weiboReturnURL
                                            authType:SSDKAuthTypeWeb];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:WechatId
                                       appSecret:WechatSecret];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:QQID
                                      appKey:QQKey
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
             break;}
     }];

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
