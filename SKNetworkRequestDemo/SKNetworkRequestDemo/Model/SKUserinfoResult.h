//
//  SKUserinfoResult.h
//  SKNetworkRequestDemo
//
//  Created by shavekevin on 2017/11/21.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "SKRealmResult.h"
@class SKUserInfoModel;
@interface SKUserinfoResult : SKRealmResult

@property (nonatomic, copy) NSArray<SKUserInfoModel *> *dataList;

@end
