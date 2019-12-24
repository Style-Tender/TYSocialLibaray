//
//  TYShareBuilder.h
//  TYSocialLibaray
//
//  Created by heimou on 2019/12/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,TYSocialPlatForm){
    TYSocialPlatForm_QQ = 0,
    TYSocialPlatForm_WeChat,
    TYSocialPlatForm_Sina,
    TYSocialPlatForm_WeChat_PYQ,
    TYSocialPlatForm_FaceBook,
    TYSocialPlatForm_Twitter
};

@class TYShareBuilder;

typedef void(^ShareCallBack)(id result, NSError *error);

typedef void(^UIShareBuilder)(UIViewController *vc);
typedef void(^ShareBuilder)(TYSocialPlatForm platform,UIViewController *vc);

typedef TYShareBuilder *_Nonnull(^TextBuilder)(NSString *text);
typedef TYShareBuilder *_Nonnull(^ImageBuilder)(NSString *imageUrl,UIImage *_Nullable thumbImage);
typedef TYShareBuilder *_Nonnull(^WebBuilder)(NSString *title,NSString *descr,id thumbImage,NSString *webUrl);

@interface TYShareBuilder : NSObject

-(instancetype)initWithShareCallBack:(ShareCallBack)callback;

///构建文字分享
-(TextBuilder)text;
///构建图片分享
-(ImageBuilder)image;
///构建H5分享
-(WebBuilder)web;

///分享
-(ShareBuilder)share;
-(UIShareBuilder)uiShare;

@end

NS_ASSUME_NONNULL_END
