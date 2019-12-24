//
//  TYShareBuilder.m
//  TYSocialLibaray
//
//  Created by heimou on 2019/12/24.
//

#import "TYShareBuilder.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

@interface TYShareBuilder ()

@property (nonatomic,strong) UMSocialMessageObject *obj;
@property (nonatomic,copy) ShareCallBack callback;

@end

@implementation TYShareBuilder

-(instancetype)initWithShareCallBack:(ShareCallBack)callback{
    self = [super init];
    if (self) {
        self.obj = [UMSocialMessageObject messageObject];
        self.callback = callback;
    }
    return self;
}

#pragma mark - 构建分享体
-(TextBuilder)text{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *text){
        weakSelf.obj.text = text;
        return weakSelf;
    };
}

-(ImageBuilder)image{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *imageUrl,UIImage *_Nullable thumbImage){
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        //如果有缩略图，则设置缩略图
        if(thumbImage != nil){
            shareObject.thumbImage = thumbImage;
        }
        [shareObject setShareImage:imageUrl];
        weakSelf.obj.shareObject = shareObject;
        return weakSelf;
    };
}

-(WebBuilder)web{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *title,NSString *descr,id thumbImage,NSString *webUrl){
        //创建图片内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumbImage];
        shareObject.webpageUrl = webUrl;
        weakSelf.obj.shareObject = shareObject;
        return weakSelf;
    };
    
}

#pragma mark - 分享
///直接分享
-(ShareBuilder)share{
    __weak typeof(self) weakSelf = self;
    return ^(TYSocialPlatForm platform,UIViewController *vc){
        [[UMSocialManager defaultManager] shareToPlatform:[weakSelf getUMPlatform:platform] messageObject:weakSelf.obj currentViewController:vc completion:^(id result, NSError *error) {
            weakSelf.callback(result,error);
        }];
    };
}
-(UIShareBuilder)uiShare{
    __weak typeof(self) weakSelf = self;
    return ^(UIViewController *vc){
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:weakSelf.obj currentViewController:vc completion:^(id result, NSError *error) {
                weakSelf.callback(result,error);
            }];
        }];
    };
}

#pragma mark - 私有方法
///TYPlatform ---> UMPlatform
-(UMSocialPlatformType)getUMPlatform:(TYSocialPlatForm) platform{
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
