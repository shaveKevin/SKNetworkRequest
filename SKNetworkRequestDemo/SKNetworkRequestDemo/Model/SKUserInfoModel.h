//
//  SKUserInfoModel.h
//  SKNetworkRequestDemo
//
//  Created by shavekevin on 2017/11/21.
//  Copyright © 2017年 shavekevin. All rights reserved.
//

#import <Realm/Realm.h>

@interface SKUserInfoModel : RLMObject

@property NSString *customerId;

@property NSString *medicalTitleShow;

@property NSString *birthday;

@property NSString *sex;

@property NSString *workplace;

@property NSString *fullName;

@property NSString *companyId;

@end
