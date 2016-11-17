//
//  SKNetWorkRequest.h
//  SKNewNetworkRequest
//
//  Created by shavekevin on 16/7/20.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "SKNetworkBaseRequest.h"

@class SKResult;
@interface SKNetWorkRequest : SKNetworkBaseRequest
///data.
@property (nonatomic, strong) SKResult * result;
@property (nonatomic, strong) NSMutableArray *arrayData;

/**
 * 是否忽略缓存
 */
@property (nonatomic, assign) BOOL ignoreCache;

/**
 * 重载 数据模型
 */
- (Class)jsonModelClass:(NSDictionary *)dictResult;
/**
 * 重载 缓存数据
 */
- (void)cacheResult;

- (void)dealWithData;
@end
