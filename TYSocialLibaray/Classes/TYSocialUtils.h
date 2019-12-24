//
//  TYSocialUtils.h
//  TYSocialLibaray
//
//  Created by heimou on 2019/12/24.
//

#import <Foundation/Foundation.h>
#import "TYUserInfo.h"
#import "TYShareBuilder.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSocialUtils : NSObject

///初始化SDK
+(void)ty_initSDK:(NSString *)umKey withChannel:(nullable NSString *)channel;
///设置调试模式
+(void)ty_debug:(BOOL)debug;
///配置key以及secret[QQ没有secret]
+(void)ty_setupPlatForm:(TYSocialPlatForm) platform Key:(NSString *)key andSecret:(nullable NSString *)secret;
///接收系统回调
+(BOOL)ty_handleOpenUrl:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

///三方登录
+(void)ty_loginPlatForm:(TYSocialPlatForm)platform inViewController:(nullable UIViewController *)vc withResult:(void(^)(NSError *_Nullable error,TYUserInfo *info,TYSocialPlatForm plat))callback;
///分享
+(TYShareBuilder *)ty_getShareBuilderWith:(void(^)(id result, NSError *error))callback;

+(TYShareBuilder *)ty_getShareBuilderWithCallBack:(ShareCallBack)callback;

@end

NS_ASSUME_NONNULL_END
