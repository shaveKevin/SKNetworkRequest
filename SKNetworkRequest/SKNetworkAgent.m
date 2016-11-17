//
//  SKNetworkAgent.m
//  SKNewNetworkRequest
//
//  Created by shavekevin on 16/7/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkAgent.h"

@interface SKNetworkAgent()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *requestsRecord;
@end
@implementation SKNetworkAgent

+ (SKNetworkAgent*)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.operationQueue.maxConcurrentOperationCount = 10;
        _requestsRecord = [NSMutableDictionary dictionary];
    }
    return self;
}

- (NSString*)buildRequestUrl:(SKNetworkBaseRequest*)request {
    NSString* detailUrl = [request requestUrl];
    if ([detailUrl hasPrefix:@"http"] || [detailUrl hasPrefix:@"https"]) {
        return detailUrl;
    }
    
    NSString* baseUrl;
    if ([request useCDN]) {
        if ([request cdnUrl].length > 0) {
            baseUrl = [request cdnUrl];
        }
        else {
            baseUrl = [request cdnUrl];
        }
    }
    else {
        if ([request baseUrl].length > 0) {
            baseUrl = [request baseUrl];
        }
        else {
            baseUrl = [request baseUrl];
        }
    }
    
    NSString* buildURL = [NSString stringWithFormat:@"%@%@", baseUrl, detailUrl];
    return buildURL;
}

- (void)addRequest:(SKNetworkBaseRequest*)request {
    NSString* url = [self buildRequestUrl:request];
    
    id requestArgument = request.requestArgument;
    NSDictionary * baseRequestArgument = [request baseRequestArgument];
    
    NSMutableDictionary * param = [requestArgument mutableCopy];
    [param setValuesForKeysWithDictionary:baseRequestArgument];
    
    /// 下面的是我们的接口需要拼的 我们使用了一个queryJson 串
    /*
    SKRequestMethod method = [request requestMethod];
    if (method == SKRequestMethodGet && param) {
        NSData * data = [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil];
        param = [NSMutableDictionary dictionaryWithObject:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] forKey:@"queryJson"];
    }
     */
    
    [self request:request url:url param:param];
}

- (void)request:(SKNetworkBaseRequest*)request url:(NSString*)url param:(NSDictionary*)param
{
    SKRequestMethod method = [request requestMethod];
    AFConstructingBlock constructingBlock = [request constructingBodyBlock];
    
    // requestSerializer
    if (request.requestSerializerType == SKRequestSerializerTypeHTTP) {
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    else if (request.requestSerializerType == SKRequestSerializerTypeJSON) {
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    _manager.requestSerializer.timeoutInterval = [request requestTimeoutInterval];
    
    // if api need server username and password
    NSArray* authorizationHeaderFieldArray = [request requestAuthorizationHeaderFieldArray];
    if (authorizationHeaderFieldArray != nil) {
        [_manager.requestSerializer setAuthorizationHeaderFieldWithUsername:(NSString*)authorizationHeaderFieldArray.firstObject password:(NSString*)authorizationHeaderFieldArray.lastObject];
    }
    
    // if api need add custom value to HTTPHeaderField
    NSDictionary* headerFieldValueDictionary = [request requestHeaderFieldValueDictionary];
    if (headerFieldValueDictionary != nil) {
        for (id httpHeaderField in headerFieldValueDictionary.allKeys) {
            id value = headerFieldValueDictionary[httpHeaderField];
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                [_manager.requestSerializer setValue:(NSString*)value forHTTPHeaderField:(NSString*)httpHeaderField];
            }
            else {
            }
        }
    }
    
    if (method == SKRequestMethodGet) {
        request.task = [_manager GET:url
                          parameters:param
                            progress:^(NSProgress * _Nonnull progress) {
                                [self handleRequestProgress:progress request:request];
                            }
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                 request.responseObject = responseObject;
                                 [self handleRequestResult:task];
                             }
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                 request.error = error;
                                 [self handleRequestResult:task];
                             }];
    }
    else if (method == SKRequestMethodPost) {
        if (constructingBlock != nil) {
            request.task = [_manager POST:url
                               parameters:param
                constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {}
                                 progress:^(NSProgress * _Nonnull uploadProgress) {
                                     [self handleRequestProgress:uploadProgress request:request];
                                 }
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      request.responseObject = responseObject;
                                      [self handleRequestResult:task];
                                  }
                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      request.error = error;
                                      [self handleRequestResult:task];
                                  }];
        }
        else {
            request.task = [_manager POST:url parameters:param
                                 progress:^(NSProgress * _Nonnull uploadProgress) {
                                     [self handleRequestProgress:uploadProgress request:request];
                                 }
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      request.responseObject = responseObject;
                                      [self handleRequestResult:task];
                                  }
                                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      request.error = error;
                                      [self handleRequestResult:task];
                                  }];
        }
    }
    else if (method == SKRequestMethodPut) {
        request.task = [_manager PUT:url
                          parameters:param
                             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                 request.responseObject = responseObject;
                                 [self handleRequestResult:task];
                             }
                             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                 request.error = error;
                                 [self handleRequestResult:task];
                             }];
    }
    else {
        return;
    }
    
    [self addOperation:request];
}

- (void)cancelRequest:(SKNetworkBaseRequest*)request
{
    [request.task cancel];
    [request clearCompletionBlock];
    [self removeOperation:request.task];
}

- (void)cancelAllRequests
{
    NSDictionary* copyRecord = [_requestsRecord copy];
    for (NSString* key in copyRecord) {
        SKNetworkBaseRequest* request = copyRecord[key];
        [request stop];
    }
}

- (void)handleRequestProgress:(NSProgress *)progress request:(SKNetworkBaseRequest*)request {
    if (request.delegate != nil) {
        [request.delegate requestProgress:progress request:request];
    }
    if(request.progressBlock) {
        request.progressBlock(progress);
    }
}

- (void)handleRequestResult:(NSURLSessionDataTask*)task {
    NSString* key = [self requestHashKey:task];
    SKNetworkBaseRequest* request = _requestsRecord[key];
    if (request) {
        if ([request statusCodeValidator]) {
            [request requestCompleteFilter];
            if (request.delegate != nil) {
                [request.delegate requestFinished:request];
            }
            if (request.successCompletionBlock) {
                request.successCompletionBlock(request);
            }
        }
        else {
            [request requestFailedFilter];
            if (request.delegate != nil) {
                [request.delegate requestFailed:request];
            }
            if (request.failureCompletionBlock) {
                request.failureCompletionBlock(request);
            }
        }
    }
    [self removeOperation:task];
    [request clearCompletionBlock];
}

- (NSString*)requestHashKey:(NSURLSessionDataTask*)task
{
    NSString* key = [NSString stringWithFormat:@"%lu", (unsigned long)[task hash]];
    return key;
}

- (void)addOperation:(SKNetworkBaseRequest*)request
{
    if (request.task != nil) {
        NSString* key = [self requestHashKey:request.task];
        @synchronized(self)
        {
            _requestsRecord[key] = request;
        }
    }
}

- (void)removeOperation:(NSURLSessionDataTask*)task
{
    NSString* key = [self requestHashKey:task];
    @synchronized(self)
    {
        [_requestsRecord removeObjectForKey:key];
    }
}

@end
