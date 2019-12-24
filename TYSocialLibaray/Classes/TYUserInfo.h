//
//  TYUserInfo.h
//  TYSocialLibaray
//
//  Created by heimou on 2019/12/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYUserInfo : NSObject

@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *unionid;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *iconurl;

@property (nonatomic,strong) NSDictionary *originalDict;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
