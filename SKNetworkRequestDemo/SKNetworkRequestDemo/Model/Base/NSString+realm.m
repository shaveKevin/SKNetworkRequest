//
//  NSString+realm.m
//  TestRealm
//
//  Created by shavekevin on 2017/11/2.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import "NSString+realm.h"

@implementation NSString (realm)

+ (NSString *)getRealmURL{
    //自定义数据库名字和路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * pathName = [path  stringByAppendingPathComponent:@"SKNetworkRealm.realm"];
    return pathName;
}

@end
