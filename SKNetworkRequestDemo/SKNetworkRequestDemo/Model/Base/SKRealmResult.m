//
//  SKRealmResult.m
//  SKNetworkRequestDemo
//
//  Created by shavekevin on 2017/11/21.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKRealmResult.h"
#import "YYModel.h"

@implementation SKRealmResult

/// 解析所有json数据
+ (instancetype)parseTotalJson:(NSDictionary *)jsDic{
    
    NSDictionary * responseData = jsDic[@"responseData"];
    SKRealmResult * result = [[self class] parseSubJson:responseData];
    
    if(!result) {
        result = [SKRealmResult new];
    }
    
    NSString * responseMessage = jsDic[@"responseMessage"];
    result.responseMessage = responseMessage;
    
    NSString * responseCode = jsDic[@"responseCode"];
    result.responseCode = responseCode;
    
    NSNumber * responseStatus = jsDic[@"responseStatus"];
    result.responseStatus = responseStatus;
    
    NSNumber * responsePk = jsDic[@"responsePk"];
    result.responsePk = responsePk;
    
    return result;
}

/// 解析responseData json数据
+ (instancetype)parseSubJson:(NSDictionary *)jsDic{
    SKRealmResult * result = [[self class] yy_modelWithDictionary:jsDic];
    return result;
}


@end
