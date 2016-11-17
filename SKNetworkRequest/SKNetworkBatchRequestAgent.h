//
//  SKNetworkBatchRequestAgent.h
//  SKNewNetworkRequest
//
//  Created by shavekevin on 16/7/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SKNetworkBatchRequest;

@interface SKNetworkBatchRequestAgent : NSObject

/**
 *  单例
 *
 *  @return id
 */
+ (SKNetworkBatchRequestAgent *)sharedInstance;

/**
 *  添加组请求
 *
 *  @param request 组请求
 */
- (void)addBatchRequest:(SKNetworkBatchRequest *)request;

/**
 *  移除组请求
 *
 *  @param request 组请求
 */
- (void)removeBatchRequest:(SKNetworkBatchRequest *)request;
@end
