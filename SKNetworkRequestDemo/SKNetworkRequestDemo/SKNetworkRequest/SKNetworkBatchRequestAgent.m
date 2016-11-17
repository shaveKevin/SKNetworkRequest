//
//  SKNetworkBatchRequestAgent.m
//  SKNewNetworkRequest
//
//  Created by shavekevin on 16/7/19.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkBatchRequestAgent.h"
#import "SKNetworkBatchRequest.h"

@interface SKNetworkBatchRequestAgent ()

@property (strong, nonatomic) NSMutableArray *requestArray;

@end
@implementation SKNetworkBatchRequestAgent

+ (SKNetworkBatchRequestAgent *)sharedInstance {
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
        _requestArray = [NSMutableArray array];
    }
    return self;
}

- (void)addBatchRequest:(SKNetworkBatchRequest *)request {
    @synchronized(self) {
        [_requestArray addObject:request];
    }
}

- (void)removeBatchRequest:(SKNetworkBatchRequest *)request {
    @synchronized(self) {
        [_requestArray removeObject:request];
    }
}
@end
