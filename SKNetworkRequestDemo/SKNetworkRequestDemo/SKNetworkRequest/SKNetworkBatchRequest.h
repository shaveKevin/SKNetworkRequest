//
//  SKNetworkBatchRequest.h
//  SKNewNetworkRequest
//
//  Created by shavekevin on 16/7/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKNetworkBaseRequest.h"
#import "SKNetworkBatchRequestAgent.h"
@class SKNetworkBatchRequest;
/// 组请求协议.
@protocol SKBatchRequestDelegate <NSObject>

@optional
/**
 *  成功
 *
 *  @param batchRequest 请求组
 */
- (void)batchRequestFinished:(SKNetworkBatchRequest *)batchRequest;

/**
 *  失败
 *
 *  @param batchRequest 请求组
 */
- (void)batchRequestFailed:(SKNetworkBatchRequest *)batchRequest;

@end


/**
 *  每个请求的回调
 *
 *  @param batchRequest 请求所在组
 *  @param baseRequest  单个请求
 */
typedef void (^BatchCallback)(SKNetworkBatchRequest *batchRequest, SKNetworkBaseRequest *baseRequest);

@interface SKNetworkBatchRequest : NSObject
/**
 *  多个请求
 */
@property (strong, nonatomic, readonly) NSMutableArray *requestArray;

/**
 *  代理
 */
@property (weak, nonatomic) id<SKBatchRequestDelegate> delegate;

/**
 *  成功
 */
@property (nonatomic, copy) void (^successCompletionBlock)(SKNetworkBatchRequest *);

/**
 *  失败
 */
@property (nonatomic, copy) void (^failureCompletionBlock)(SKNetworkBatchRequest *, SKNetworkBaseRequest *);

/**
 *  tag
 */
@property (nonatomic) NSInteger tag;

/**
 *  初始化
 *
 *  @param requestArray 一组请求
 *
 *  @return id
 */
- (id)initWithRequestArray:(NSArray *)requestArray;

/**
 *  开始请求
 */
- (void)start;

/**
 *  停止请求
 */
- (void)stop;

/// block回调

/**
 *  组请求开始（block）
 *
 *  @param success 组请求成功block
 *  @param failure 组请求失败block
 */
- (void)startWithCompletionBlockWithSuccess:(void (^)(SKNetworkBatchRequest *batchRequest))success
                                    failure:(void (^)(SKNetworkBatchRequest *batchRequest,SKNetworkBaseRequest *baseRequest))failure;

/**
 *  设置组请求成功和失败block
 *
 *  @param success 组请求成功block
 *  @param failure 组请求失败block
 */
- (void)setCompletionBlockWithSuccess:(void (^)(SKNetworkBatchRequest *batchRequest))success
                              failure:(void (^)(SKNetworkBatchRequest *batchRequest,SKNetworkBaseRequest *baseRequest))failure;

/**
 *  把block置nil来打破循环引用
 */
- (void)clearCompletionBlock;
/**
 *  添加组请求
 *
 *  @param request  请求
 *  @param successCallback 成功回调
 *  @param failCallback 失败回调
 */
- (void)addRequest:(SKNetworkBaseRequest *)request
   successCallback:(void (^)(SKNetworkBaseRequest * baseRequest))successCallback
      failCallback:(void (^)(SKNetworkBaseRequest * baseRequest))failCallback;

/**
 *  请求数组
 *
 *  @return value
 */
- (NSArray *)requestArray;

@end
