//
//  SKUserInfoModel.m
//  SKNetworkRequestDemo
//
//  Created by shavekevin on 2017/11/21.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKUserInfoModel.h"

@implementation SKUserInfoModel

/*
 * 解析
 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"customerId" : @"uniteMap.customerId",
             @"medicalTitleShow":@"authMap.medicalTitleShow",
             @"birthday":@"authMap.birthday",
             @"sex":@"authMap.sex",
             @"workplace":@"authMap.workplace",
             @"fullName":@"authMap.fullName",
             @"companyId":@"authMap.companyId"
             };
}

+ (NSString *)primaryKey {
    
    return @"customerId";
}

@end
