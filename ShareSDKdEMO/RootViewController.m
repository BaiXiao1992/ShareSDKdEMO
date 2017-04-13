//
//  RootViewController.m
//  ShareSDKdEMO
//
//  Created by 白晓 on 2017/2/20.
//  Copyright © 2017年 白晓. All rights reserved.
//

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

//#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#import <TencentOpenAPI/QQApiInterface.h>

#import "shareFunction.h"


@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    }

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 50, 150, 50);
    [button setTitle:@"share" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(share1) forControlEvents:UIControlEventTouchUpInside];
//    showsSearchClick
    [self.view addSubview:button];
//    [self shareSDK];
//    self.shareParams = [NSMutableDictionary dictionary];

    // Do any additional setup after loading the view.
}


- (void)share1{
    
    shareFunction *share = [[shareFunction alloc] init];
    share.title = [[NSString alloc] initWithFormat:@"%@",@"123"];
    share.text = @"123";
    share.shareUrl = @"http://www.baidu.com";
    share.shareImage = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490699265336&di=5c21c8f4bf78774ac99fe6eb2f321f02&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F015d645746fb876ac72525ae3efaf6.jpg%40900w_1l_2o_100sh.jpg";
    [share showShare];
//    shareFunctionView *share =[[shareFunctionView alloc] init];
//    [share universalShareFunction:@"1234567890" imagerName:nil url:nil title:@"title" type:0];
//    [share sendShareText];
}

//@"http://www.baidu.com" 
- (void)showsSearchClick{
    if ([QQApiInterface isQQInstalled]) {
        NSLog(@"QQ已安装");
    }else{
        NSLog(@"QQ未安装");
    }

    //1、创建分享参数（必要）
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:[UIImage imageNamed:@"shareImg"]
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    
    // 定制新浪微博的分享内容
    [shareParams SSDKSetupSinaWeiboShareParamsByText:@"定制新浪微博的分享内容"                                       title:nil
                                               image:[UIImage imageNamed:@"shareImg.png"]
                                                 url:nil
                                            latitude:0
                                           longitude:0
                                            objectID:nil
                                                type:SSDKContentTypeAuto];
    /*
     新浪微博分享的时候出现：sso package or sign error。出现这个问题是因为你在新浪微博开放平台上申请的应用的bundle identifier 和你项目的bundle identifier不一致造成的。
     */
    
    [shareParams SSDKSetupQQParamsByText:@"定制新浪微博的分享内容" title:@"定制新浪微博的分享内容" url:[NSURL URLWithString:@"http://mob.com"] thumbImage:[UIImage imageNamed:@"shareImg.png"] image:[UIImage imageNamed:@"shareImg.png"] type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQZone];
    [shareParams SSDKSetupQQParamsByText:@"定制QQ的分享内容" title:@"定制QQ的分享内容" url:[NSURL URLWithString:@"http://mob.com"] thumbImage:[UIImage imageNamed:@"shareImg.png"] image:[UIImage imageNamed:@"shareImg.png"] type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    // 定制微信好友的分享内容
    
    [shareParams SSDKSetupWeChatParamsByText:@"定制微信的分享内容"  title:@"title" url:[NSURL URLWithString:@"http://mob.com"] thumbImage:nil image:[UIImage imageNamed:@"shareImg.png"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto  forPlatformSubType:SSDKPlatformSubTypeWechatSession];// 微信好友子平台
    [shareParams SSDKSetupWeChatParamsByText:@"定制微信的分享内容"  title:@"title" url:[NSURL URLWithString:@"http://mob.com"] thumbImage:nil image:[UIImage imageNamed:@"shareImg.png"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto  forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];// 微信朋友圈子平台
    [shareParams SSDKSetupWeChatParamsByText:@"定制微信的分享内容"  title:@"title" url:[NSURL URLWithString:@"http://mob.com"] thumbImage:nil image:[UIImage imageNamed:@"shareImg.png"] musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil type:SSDKContentTypeAuto  forPlatformSubType:SSDKPlatformSubTypeWechatFav];// 微信收藏子平台

    //2、分享;
    [ShareSDK showShareActionSheet:nil
                             items:nil
                       shareParams:shareParams
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   switch (state) {
                       case SSDKResponseStateSuccess:
                       {
                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                           [alertView show];
                           break;
                       }
                       case SSDKResponseStateFail:
                       {
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                           NSLog(@"error = %@",error);
                           [alert show];
                           break;
                       }
                       default:
                           break;
                   }
               }];
}

- (void)showsSearchClick:(id)sender{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];

        //2、分享（可以弹出我们的分享菜单和编辑界面）
       [ShareSDK showShareActionSheet:nil
         //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               NSLog(@"error = %@",error);
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];

 }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
