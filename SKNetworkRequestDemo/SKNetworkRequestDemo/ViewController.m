//
//  ViewController.m
//  SKNewNetworkRequest
//
//  Created by shavekevin on 2016/11/17.
//  Copyright © 2016年 shavekevin. All rights reserved.
//

#import "ViewController.h"
#import "SKStaticNewsList_request.h"
#import "SKStaticNewsListModel.h"
#import "SKStaticNewsListResult.h"
#import "SKNetworkBatchRequest.h"
#import "SKUserinfoRequest.h"
#import "SKUserinfoResult.h"
#import "SKUserInfoModel.h"
#import <Masonry.h>
#import "NSString+realm.h"

@interface ViewController ()

/**
 *  @brief 请求1 .
 */
@property (nonatomic, strong) SKStaticNewsList_request *newsListGroupRequest;

/**
 *  @brief 请求2 .
 */
@property (nonatomic, strong) SKStaticNewsList_request *newsListRequest;

@property (nonatomic, assign) NSInteger pageFrom;
/**
 *  @brief SKStaticNewsListModel .
 */
@property (nonatomic, strong) NSMutableArray <SKStaticNewsListModel *> *arrayModelList;
/**
 *  @brief group request .
 */
@property(nonatomic,strong)SKNetworkBatchRequest *batchRequest;

@property (nonatomic, strong) SKUserinfoRequest *userinfoRequest;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
    [self request];
}
#pragma mark  - 初始化
- (void)initData {
    self.view.backgroundColor = [UIColor whiteColor];
    _pageFrom = 0;
    self.arrayModelList = [NSMutableArray array];
}

#pragma mark - 网络请求
//  请求
- (void)request {
    
    ///  异步
    
    //[self getNewsListData];
    
    ///  同步  .
//    [self getBatchRequest];
    [self pressAction:nil];
}

/**
 *  @brief 新的网络请求
 */
- (void)getNewsListData {
    if (_newsListRequest) {
        [_newsListRequest stop];
        _newsListRequest = nil;
    }
    _newsListRequest = [[SKStaticNewsList_request alloc]init];
    _newsListRequest.firstResult = [NSString stringWithFormat:@"%ld",(long)_pageFrom];
    _newsListRequest.type = @"科技";
    _newsListRequest.uid = @"23080";
    [_newsListRequest startCompletionBlockWithProgress:^(NSProgress *progress) {
        //
    } success:^(SKNetworkBaseRequest *request) {
        //
        SKStaticNewsList_request *reviewRequest = (SKStaticNewsList_request*)request;
        
        SKStaticNewsListResult *result = (SKStaticNewsListResult *)reviewRequest.result;
        [self dealWithData:result];
    } failure:^(SKNetworkBaseRequest *request) {
        
    }];
}
/**
 *  @brief 新的网络请求 处理逻辑放在VC
 *
 *  @param result 新的网络请求
 */
- (void)dealWithData:(SKStaticNewsListResult *)result {
    
    [self.arrayModelList addObjectsFromArray:result.arrayList];
    NSLog(@"%ld",self.arrayModelList.count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getBatchRequest {
    if(_batchRequest) {
        _batchRequest = nil;
        [_batchRequest stop];
    }
    _batchRequest = [[SKNetworkBatchRequest alloc] init];
    
    [self getNewsListGroupData];
    [self getNewsGroupListData];
    
    [_batchRequest startWithCompletionBlockWithSuccess:^(SKNetworkBatchRequest *batchRequest) {
        //
    } failure:^(SKNetworkBatchRequest *batchRequest, SKNetworkBaseRequest *baseRequest) {
        //
    }];
    
}

- (void)getNewsListGroupData {
    if (_newsListRequest) {
        [_newsListRequest stop];
        _newsListRequest = nil;
    }
    _newsListRequest = [[SKStaticNewsList_request alloc]init];
    _newsListRequest.firstResult = [NSString stringWithFormat:@"%ld",(long)_pageFrom];
    _newsListRequest.type = @"科技";
    _newsListRequest.uid = @"23080";
    
    [_batchRequest addRequest:_newsListRequest successCallback:^(SKNetworkBaseRequest *baseRequest) {
        //
        //
        
        SKStaticNewsList_request *reviewRequest = (SKStaticNewsList_request*)baseRequest;
        SKStaticNewsListResult *result = (SKStaticNewsListResult *)reviewRequest.result;
        NSLog(@"----请求 1-----%ld",result.arrayList.count);
        
    } failCallback:^(SKNetworkBaseRequest *baseRequest) {
        //
    }];
    
    
}

- (void)getNewsGroupListData {
    if (_newsListGroupRequest) {
        [_newsListGroupRequest stop];
        _newsListGroupRequest = nil;
    }
    _newsListGroupRequest = [[SKStaticNewsList_request alloc]init];
    _pageFrom = 20;
    _newsListGroupRequest.firstResult = [NSString stringWithFormat:@"%ld",(long)_pageFrom];
    _newsListGroupRequest.type = @"科技";
    _newsListGroupRequest.uid = @"23080";
    [_batchRequest addRequest:_newsListGroupRequest successCallback:^(SKNetworkBaseRequest *baseRequest) {
        //
        SKStaticNewsList_request *reviewRequest = (SKStaticNewsList_request*)baseRequest;
        SKStaticNewsListResult *result = (SKStaticNewsListResult *)reviewRequest.result;
        NSLog(@"----请求 2-----%ld",result.arrayList.count);
        
    } failCallback:^(SKNetworkBaseRequest *baseRequest) {
        //
    }];
    
}

- (void)pressAction:(UIButton *)sender {
    if (self.userinfoRequest) {
        [self.userinfoRequest stop];
        self.userinfoRequest = nil;
    }
    [self.userinfoRequest startCompletionBlockWithProgress:^(NSProgress *progress) {
        //
    } success:^(SKNetworkBaseRequest *request) {
        //
        SKUserinfoResult *result =  self.userinfoRequest.uerInfoResult;
        if (result.dataList&& result.dataList.count) {
            SKUserInfoModel *model = [result.dataList firstObject];
            RLMRealm * realm = [RLMRealm realmWithURL:[NSURL URLWithString:[NSString getRealmURL]]];
            //查询所有
            RLMResults * userInfoModelArr = [SKUserInfoModel allObjectsInRealm:realm];
            NSLog(@" =查询出来的userInfoModelArr == %@",userInfoModelArr);
            //update
            if (userInfoModelArr&&userInfoModelArr.count) {
                SKUserInfoModel *userInfoModel = userInfoModelArr.firstObject;
                [realm beginWriteTransaction];
                userInfoModel.sex = @"女";
                [realm commitWriteTransaction];
                RLMResults * userInfoModel1 = [SKUserInfoModel allObjectsInRealm:realm];
                NSLog(@" =更改后userInfoModel== %@",userInfoModel1.firstObject);
                
            }else{
                //create
                [realm beginWriteTransaction];
                [SKUserInfoModel createOrUpdateInRealm:realm withValue:model];
                [realm commitWriteTransaction];
                RLMResults * userInfoModel = [SKUserInfoModel allObjectsInRealm:realm];
                NSLog(@" =创建后userInfoModel== %@",userInfoModel.firstObject);

            }

        }
        
    } failure:^(SKNetworkBaseRequest *request) {
        //
    }];
}

- (void)deleteUserInfoDataBase {
    RLMRealm * realm = [RLMRealm realmWithURL:[NSURL URLWithString:[NSString getRealmURL]]];
    //查询所有
    RLMResults * presons = [SKUserInfoModel allObjectsInRealm:realm];
    //    NSLog(@" === %@",presons);
    if (presons && presons.count) {
        SKUserInfoModel *result1 = [presons firstObject];
        // 删除某一条数据
        if ([result1.customerId isEqualToString:@"1111111000000000"]) {
            NSLog(@"%@",result1);
            [realm transactionWithBlock:^{
                [realm deleteObject:result1];
            }];
        }
    }
}

//清除一次数据库
- (void)cleanRealm{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    NSArray<NSURL *> *realmFileURLs = @[
                                        config.fileURL,
                                        [config.fileURL URLByAppendingPathExtension:@"lock"],
                                        [config.fileURL URLByAppendingPathExtension:@"management"],
                                        ];
    for (NSURL *URL in realmFileURLs) {
        NSError *error = nil;
        [manager removeItemAtURL:URL error:&error];
        if (error) {
            NSLog(@"clean realm error:%@", error);
        }else{
            NSLog(@"清楚成功");
        }
    }
    
    RLMRealm * realm = [RLMRealm realmWithURL:[NSURL URLWithString:[NSString getRealmURL]]];
    [realm transactionWithBlock:^{
        [realm deleteAllObjects];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//     if ([[segue identifier]isEqualToString:@"DetailViewController"]) {
//         statements
//     }
// }

- (SKUserinfoRequest *)userinfoRequest {
    if (!_userinfoRequest) {
        _userinfoRequest = [[SKUserinfoRequest alloc]init];
    }
    return _userinfoRequest;
    
}



@end
