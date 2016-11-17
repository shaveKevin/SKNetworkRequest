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
    [self getBatchRequest];
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
@end
