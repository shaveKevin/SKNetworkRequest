//
//  SKNetWorkRequest.m
//  SKNewNetworkRequest
//
//  Created by shavekevin on 16/7/20.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetWorkRequest.h"
#import "SKResult.h"

@implementation SKNetWorkRequest

- (instancetype)init {
    
    if(self = [super init]) {
        self.arrayData = [[NSMutableArray alloc] initWithCapacity:0];
        self.ignoreCache = YES;
    }
    return self;
}

- (void)start {
    [super start];
}

- (NSString *)baseUrl {
    return nil;
}

- (NSString *)cdnUrl {
    return nil;
}

/*
///  公共参数 .
- (NSDictionary*)baseRequestArgument{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    return dic;
}
*/
/// 请求失败
- (void)requestFailedFilter {
}

/// 请求成功
- (void)requestCompleteFilter {
    [self convertJson];
    
    if(self.ignoreCache == NO){
        [self cacheResult];
    }
    
    [self dealWithData];
}

- (void)dealWithData
{}

- (void)convertJson{
    NSDictionary * result = self.responseObject;
    if([self jsonModelClass:result] &&
       [[self jsonModelClass:result] isSubclassOfClass:[SKResult class]]) {
        id obj = [[self jsonModelClass:result] parseTotalJson:result];
        self.result = obj;
    }
}

/**
 *  @brief yymodel
 *
 *  @param dictResult 映射
 *
 *  @return yymodel映射
 */
- (Class)jsonModelClass:(NSDictionary *)dictResult {
    return [SKResult class];
}
- (void)cacheResult{
    
}


@end
