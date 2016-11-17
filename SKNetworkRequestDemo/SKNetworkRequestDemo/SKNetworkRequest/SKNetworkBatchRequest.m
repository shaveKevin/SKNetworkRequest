//
//  SKNetworkBatchRequest.m
//  SKNewNetworkRequest
//
//  Created by shavekevin on 16/7/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkBatchRequest.h"

@interface SKNetworkBatchRequest()<SKRequestDelegate>

@property (nonatomic) NSInteger finishedCount;

@end
@implementation SKNetworkBatchRequest
- (instancetype)init {
    if (self = [super init]) {
        _requestArray = [[NSMutableArray alloc] init];
        _finishedCount = 0;
    }
    return self;
}
- (id)initWithRequestArray:(NSArray *)requestArray {
    self = [super init];
    if (self) {
        _requestArray = [NSMutableArray arrayWithArray:requestArray];
        _finishedCount = 0;
        for (SKNetworkBaseRequest * req in _requestArray) {
            if (![req isKindOfClass:[SKNetworkBaseRequest class]]) {
                return nil;
            }
        }
    }
    return self;
}

- (void)start {
    if (_finishedCount > 0) {
        return;
    }
    [[SKNetworkBatchRequestAgent sharedInstance] addBatchRequest:self];
    for (SKNetworkBaseRequest * request in _requestArray) {
        request.delegate = self;
        [request start];
    }
}

- (void)stop {
    _delegate = nil;
    [self clearRequest];
    [[SKNetworkBatchRequestAgent sharedInstance] removeBatchRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(SKNetworkBatchRequest *batchRequest))success
                                    failure:(void (^)(SKNetworkBatchRequest *batchRequest,SKNetworkBaseRequest *baseRequest))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(SKNetworkBatchRequest *batchRequest))success
                              failure:(void (^)(SKNetworkBatchRequest *batchRequest,SKNetworkBaseRequest *baseRequest))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate
- (void)requestProgress:(NSProgress *)progress request:(SKNetworkBaseRequest *)request {
}

- (void)requestFinished:(SKNetworkBaseRequest *)request {
    _finishedCount++;
    if (_finishedCount == _requestArray.count) {
        if ([_delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [_delegate batchRequestFinished:self];
        }
        if (_successCompletionBlock) {
            _successCompletionBlock(self);
        }
        [self clearCompletionBlock];
    }
}

- (void)requestFailed:(SKNetworkBaseRequest *)request {
    
    // Stop
    for (SKNetworkBaseRequest *req in _requestArray) {
        [req stop];
    }
    // Callback
    if ([_delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [_delegate batchRequestFailed:self];
    }
    if (_failureCompletionBlock) {
        _failureCompletionBlock(self,request);
    }
    // Clear
    [self clearCompletionBlock];
    [[SKNetworkBatchRequestAgent sharedInstance] removeBatchRequest:self];
}

- (void)clearRequest {
    for (SKNetworkBaseRequest * req in _requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

/**
 *  添加组请求
 *
 *  @param request  请求
 *  @param successCallback 成功回调
 *  @param failCallback 失败回调
 */
- (void)addRequest:(SKNetworkBaseRequest *)request
   successCallback:(void (^)(SKNetworkBaseRequest * baseRequest))successCallback
      failCallback:(void (^)(SKNetworkBaseRequest * baseRequest))failCallback {
    [_requestArray addObject:request];
    request.successCompletionBlock = successCallback;
    request.failureCompletionBlock = failCallback;
}
@end
