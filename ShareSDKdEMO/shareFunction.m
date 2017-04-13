//
//  shareFunction.m
//  ShareSDKdEMO
//
//  Created by 白晓 on 2017/3/6.
//  Copyright © 2017年 白晓. All rights reserved.
//

#import "shareFunction.h"


@implementation shareFunction
- (id)init {
    if (self) {
        if (!self.shareParams) {
            self.shareParams = [NSMutableDictionary dictionary];
        }
    }
    return self;
}
- (void)universalShareFunction:(NSString *)text imagerName:(NSString *)imagerName url:(NSString *)urlStr title:(NSString *)title type:(NSInteger)type{
    [self.shareParams SSDKSetupShareParamsByText:text
                                          images:imagerName
                                             url:[NSURL URLWithString:urlStr]
                                           title:title
                                            type:type];

}

- (void)WeiboShareFunction:(NSString *)text imagerName:(NSString *)imagerName url:(NSString *)urlStr title:(NSString *)title latitude:(double)latitude longitude:(double)longitude type:(NSInteger)type{
    [self.shareParams SSDKSetupSinaWeiboShareParamsByText:text
                                                    title:title
                                                    image:[UIImage imageNamed:imagerName]
                                                      url:[NSURL URLWithString:urlStr]
                                                 latitude:latitude
                                                longitude:longitude
                                                 objectID:nil
                                                     type:type];
}

- (void)QQShareFunction:(NSString *)text imagerName:(NSString *)imagerName thumbImage:(NSString *)thumbImageName url:(NSString *)urlStr audioFlashURL:(NSString *)audioFlashURL videoFlashURL:(NSString *)videoFlashURL title:(NSString *)title type:(NSInteger)type{
    [self.shareParams SSDKSetupQQParamsByText:text
                                        title:title
                                          url:[NSURL URLWithString:urlStr]
                                audioFlashURL:[NSURL URLWithString:audioFlashURL]
                                videoFlashURL:[NSURL URLWithString:videoFlashURL]
                                   thumbImage:[UIImage imageNamed:thumbImageName]
                                       images:[UIImage imageNamed:imagerName]
                                         type:type
                           forPlatformSubType:SSDKPlatformSubTypeQZone];
    [self.shareParams SSDKSetupQQParamsByText:text
                                        title:title
                                          url:[NSURL URLWithString:urlStr]
                                audioFlashURL:[NSURL URLWithString:audioFlashURL]
                                videoFlashURL:[NSURL URLWithString:videoFlashURL]
                                   thumbImage:[UIImage imageNamed:thumbImageName]
                                       images:[UIImage imageNamed:imagerName]
                                         type:type
                           forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    
}


- (void)WeChatShareFunction:(NSString *)text title:(NSString *)title imagerName:(NSString *)imagerName thumbImageName:(NSString *)thumbImageName url:(NSString *)urlStr musicFileURL:(NSString *)musicFileURL extInfo:(NSString *)extInfo fileData:(id)fileData emoticonData:(id)emoticonData fileExtension:(NSString *)fileExtension sourceFileData:(id)sourceFileData type:(NSInteger)type{
    // 微信好友子平台
    [self.shareParams SSDKSetupWeChatParamsByText:text
                                            title:title
                                              url:[NSURL URLWithString:urlStr]
                                       thumbImage:[UIImage imageNamed:thumbImageName]
                                            image:[UIImage imageNamed:imagerName]
                                     musicFileURL:[NSURL URLWithString:musicFileURL]
                                          extInfo:extInfo
                                         fileData:fileData
                                     emoticonData:emoticonData
                              sourceFileExtension:fileExtension
                                   sourceFileData:sourceFileData
                                             type:type
                               forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    // 微信朋友圈子平台
    [self.shareParams SSDKSetupWeChatParamsByText:text
                                            title:title
                                              url:[NSURL URLWithString:urlStr]
                                       thumbImage:[UIImage imageNamed:thumbImageName]
                                            image:[UIImage imageNamed:imagerName]
                                     musicFileURL:[NSURL URLWithString:musicFileURL]
                                          extInfo:extInfo
                                         fileData:fileData
                                     emoticonData:emoticonData
                              sourceFileExtension:fileExtension
                                   sourceFileData:sourceFileData
                                             type:type
                               forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
    // 微信朋友圈子平台
    [self.shareParams SSDKSetupWeChatParamsByText:text
                                            title:title
                                              url:[NSURL URLWithString:urlStr]
                                       thumbImage:[UIImage imageNamed:thumbImageName]
                                            image:[UIImage imageNamed:imagerName]
                                     musicFileURL:[NSURL URLWithString:musicFileURL]
                                          extInfo:extInfo
                                         fileData:fileData
                                     emoticonData:emoticonData
                              sourceFileExtension:fileExtension
                                   sourceFileData:sourceFileData
                                             type:type
                               forPlatformSubType:SSDKPlatformSubTypeWechatFav];
}
- (void)showShare{
    [self universalShareFunction:self.text imagerName:self.shareImage url:self.shareUrl title:self.title type:0];
    //2、分享;
    [ShareSDK showShareActionSheet:nil
                             items:nil
                       shareParams:self.shareParams
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
-(void)dealloc{
    self.shareParams = nil;
}

@end
