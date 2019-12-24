//
//  TYUserInfo.m
//  TYSocialLibaray
//
//  Created by heimou on 2019/12/24.
//

#import "TYUserInfo.h"

@implementation TYUserInfo

-(instancetype)initWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        self.originalDict = dict;
        self.uid = dict[@"uid"];
        self.unionid = dict[@"unionid"];
        self.nickName = dict[@"name"];
        self.gender = dict[@"gender"];
        self.iconurl = dict[@"iconurl"];
    }
    return self;
}

@end
