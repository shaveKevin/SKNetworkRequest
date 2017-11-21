//
//  SKUserinfoResult.m
//  SKNetworkRequestDemo
//
//  Created by shavekevin on 2017/11/21.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKUserinfoResult.h"
#import "SKUserInfoModel.h"

@implementation SKUserinfoResult

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"dataList" : [SKUserInfoModel class]
             };
}
@end
