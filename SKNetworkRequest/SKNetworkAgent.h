//
//  SKNetworkAgent.h
//  SKNewNetworkRequest
//
//  Created by shavekevin on 16/7/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SKNetworkBaseRequest.h"

@interface SKNetworkAgent : NSObject
/**
 *  单例
 *
 *  @return value
 */
+ (SKNetworkAgent *)sharedInstance;

/**
 *  添加请求
 *
 *  @param request 请求
 */
- (void)addRequest:(SKNetworkBaseRequest *)request;

/**
 *  取消请求
 *
 *  @param request 请求
 */
- (void)cancelRequest:(SKNetworkBaseRequest *)request;

/**
 *  取消全部请求
 */
- (void)cancelAllRequests;

/**
 *  请求的url
 *
 *  @param request 请求
 *
 *  @return url
 */
- (NSString *)buildRequestUrl:(SKNetworkBaseRequest *)request;

@end
