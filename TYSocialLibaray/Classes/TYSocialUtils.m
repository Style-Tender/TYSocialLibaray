//
//  TYSocialUtils.m
//  TYSocialLibaray
//
//  Created by heimou on 2019/12/24.
//

#import "TYSocialUtils.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

@interface TYSocialUtils ()

@end

@implementation TYSocialUtils

#pragma mark - 初始化SDK
///初始化
+(void)ty_initSDK:(NSString *)umKey withChannel:(nullable NSString *)channel{
    [UMConfigure initWithAppkey:umKey channel:channel];
    //关闭https的强制验证
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
///调试模式
+(void)ty_debug:(BOOL)debug{
    [UMConfigure setLogEnabled:debug];
}
///配置key以及secret[QQ没有secret]
+(void)ty_setupPlatForm:(TYSocialPlatForm) platform Key:(NSString *)key andSecret:(nullable NSString *)secret{
    [[UMSocialManager defaultManager] setPlaform:[self getUMPlatform:platform] appKey:key appSecret:secret redirectURL:@"http://mobile.umeng.com/social"];
}
///接收系统回调
+(BOOL)ty_handleOpenURL:(NSURL *)url options:(NSDictionary *)options{
    return [[UMSocialManager defaultManager] handleOpenURL:url options:options];
}

#pragma mark - 三方登录
+(void)ty_loginPlatForm:(TYSocialPlatForm)platform inViewController:(nullable UIViewController *)vc withResult:(void(^)(NSError *_Nullable error,TYUserInfo *info,TYSocialPlatForm plat))callback{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:[self getUMPlatform:platform] currentViewController:vc completion:^(id result, NSError *error) {
        if(callback){
            callback(error,[[TYUserInfo alloc]initWithDict:result],platform);
        }
    }];
}

#pragma mark - 分享
+(TYShareBuilder *)ty_getShareBuilderWith:(void(^)(id result, NSError *error))callback{
    TYShareBuilder *builder = [[TYShareBuilder alloc]initWithShareCallBack:callback];
    return builder;
}
+(TYShareBuilder *)ty_getShareBuilderWithCallBack:(ShareCallBack)callback{
    TYShareBuilder *builder = [[TYShareBuilder alloc]initWithShareCallBack:callback];
    return builder;
}
///TYPlatform ---> UMPlatform
+(UMSocialPlatformType)getUMPlatform:(TYSocialPlatForm) platform{
    /*
     TYSocialPlatForm_QQ = 0,
     TYSocialPlatForm_WeChat,
     TYSocialPlatForm_Sina,
     TYSocialPlatForm_WeChat_PYQ,
     TYSocialPlatForm_FaceBook,
     TYSocialPlatForm_Twitter
     */
    switch (platform) {
        case TYSocialPlatForm_QQ:
            return UMSocialPlatformType_QQ;
            break;
        case TYSocialPlatForm_WeChat:
            return UMSocialPlatformType_WechatSession;
            break;
        case TYSocialPlatForm_Sina:
            return UMSocialPlatformType_Sina;
            break;
        case TYSocialPlatForm_WeChat_PYQ:
            return UMSocialPlatformType_WechatTimeLine;
            break;
        case TYSocialPlatForm_FaceBook:
            return UMSocialPlatformType_Facebook;
            break;
        case TYSocialPlatForm_Twitter:
            return UMSocialPlatformType_Twitter;
            break;
        default:
            return UMSocialPlatformType_WechatSession;
            break;
    }
}

@end
