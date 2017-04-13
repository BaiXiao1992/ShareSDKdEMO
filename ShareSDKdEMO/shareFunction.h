//
//  shareFunction.h
//  ShareSDKdEMO
//
//  Created by 白晓 on 2017/3/6.
//  Copyright © 2017年 白晓. All rights reserved.
//

#import <Foundation/Foundation.h>
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
@interface shareFunction : NSObject

@property (nonatomic, retain) NSMutableDictionary *shareParams;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *shareImage;
@property (nonatomic, retain) NSString *shareUrl;
//通用分享方法
- (void)universalShareFunction:(NSString *)text imagerName:(NSString *)imagerName url:(NSString *)urlStr title:(NSString *)title type:(NSInteger)type;

//新浪微博分享方法
- (void)WeiboShareFunction:(NSString *)text imagerName:(NSString *)imagerName url:(NSString *)urlStr title:(NSString *)title latitude:(double)latitude longitude:(double)longitude type:(NSInteger)type;

//QQ分享方法
- (void)QQShareFunction:(NSString *)text imagerName:(NSString *)imagerName thumbImage:(NSString *)thumbImageName url:(NSString *)urlStr audioFlashURL:(NSString *)audioFlashURL videoFlashURL:(NSString *)videoFlashURL title:(NSString *)title type:(NSInteger)type;

//微信分享方法
- (void)WeChatShareFunction:(NSString *)text title:(NSString *)title imagerName:(NSString *)imagerName thumbImageName:(NSString *)thumbImageName url:(NSString *)urlStr musicFileURL:(NSString *)musicFileURL extInfo:(NSString *)extInfo fileData:(id)fileData emoticonData:(id)emoticonData fileExtension:(NSString *)fileExtension sourceFileData:(id)sourceFileData type:(NSInteger)type;

//发送分享信息
- (void)showShare;

@end
