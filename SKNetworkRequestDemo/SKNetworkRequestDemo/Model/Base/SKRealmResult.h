//
//  SKRealmResult.h
//  SKNetworkRequestDemo
//
//  Created by shavekevin on 2017/11/21.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SKRealmResult : NSObject

@property (nonatomic, copy) NSString * responseMessage;
@property (nonatomic, copy) NSString * responseCode;
@property (nonatomic, strong) NSNumber * responseStatus;
@property (nonatomic, strong) NSNumber * responsePk;
/*
 * 自动化解析所有json数据
 */
+ (instancetype)parseTotalJson:(NSDictionary *)jsDic;

@end
