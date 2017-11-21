//
//  SKUserinfoRequest.m
//  SKNetworkRequestDemo
//
//  Created by shavekevin on 2017/11/21.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKUserinfoRequest.h"
#import "SKUserInfoModel.h"
#import "SKUserinfoResult.h"
static NSString *const nesListAPI = @"http://47.93.118.77:18080/services/tocure/customer/unite/v1/getMapByCustomerId?queryJson=%7B%0A%20%20%22logoUseFlag%22%20%3A%20%223%22%2C%0A%20%20%22tVersion%22%20%3A%20%22iPhone%206s%22%2C%0A%20%20%22opIp%22%20%3A%20%220.0.0.0%22%2C%0A%20%20%22osVersion%22%20%3A%20%22iOS%22%2C%0A%20%20%22telecom%22%20%3A%20%223%22%2C%0A%20%20%22customerId%22%20%3A%20%221464580693119%22%2C%0A%20%20%22longitude%22%20%3A%20%22116.448659%22%2C%0A%20%20%22opAdvice%22%20%3A%20%22%E6%97%A0%2CiPhone%206s%2CiOS10.0.2%22%2C%0A%20%20%22maxResult%22%20%3A%20%2220%22%2C%0A%20%20%22netVersion%22%20%3A%20%224%22%2C%0A%20%20%22latitude%22%20%3A%20%2239.916375%22%2C%0A%20%20%22token%22%20%3A%20%22c21a0572769256a8e4bcb2606c6d71b3%22%2C%0A%20%20%22isValid%22%20%3A%20%221%22%2C%0A%20%20%22appVersion%22%20%3A%20%22122%22%2C%0A%20%20%22firstResult%22%20%3A%20%220%22%2C%0A%20%20%22visitSiteId%22%20%3A%20%2220%22%2C%0A%20%20%22currentDate%22%20%3A%20%222017-11-17%2015%3A37%3A50%22%0A%7D";

@implementation SKUserinfoRequest

/// 数据模型类
- (Class)jsonModelClass:(NSDictionary *)dictResult {
    
    return [SKUserinfoResult class];
}

// 接口
- (NSString *)requestUrl {
    return nesListAPI;
}
// 参数
- (id)requestArgument
{
    NSDictionary *dicParam = @{
                               };
    
    return dicParam;
}

// 方法
- (SKRequestMethod)requestMethod {
    
    return SKRequestMethodGet;
}


/// 请求失败
- (void)requestFailedFilter {
}

/// 请求成功
- (void)requestCompleteFilter {
    [self convertJson];
}

- (void)convertJson{
    NSDictionary * result = self.responseObject;
    if([self jsonModelClass:result] &&
       [[self jsonModelClass:result] isSubclassOfClass:[SKUserinfoResult class]]) {
        id obj = [[self jsonModelClass:result] parseTotalJson:result];
        self.uerInfoResult = obj;
    }
}

@end
