//
//  DBookViewController.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/7/31.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBookViewController.h"
#import "BAKit_BAGridView.h"
#import "BAGridView_Config.h"
#import "DBookModel.h"
#import "DBookHeaderView.h"
#import "GDTMobInterstitial.h"
#import "DBookTxtViewController.h"

@interface DBookViewController ()<GDTMobInterstitialDelegate>{
    GDTMobInterstitial *_interstitialObj;
}



@property(nonatomic, strong)  BAGridView        *gridView;
@property (nonatomic, strong) DBookHeaderView   *tableHeaderView;
@property(nonatomic, strong) BAGridView_Config *ba_GridViewConfig;
@property(nonatomic, strong) NSMutableArray    *gridDataArray;



@end

@implementation DBookViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    if ([DBookManager defaultManager].bookID) {
         [self.tableHeaderView refreshUI];
    }
    
    
    
    [self initializeRefresh];
    [self onHeaderRefreshing];
    
    

    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top = (IS_iPhoneX ? -45 : -25);
    [self.tableView setContentInset:contentInset];
    
    
//    id input=DUserDefaultsGET(kDiscuss);
//    self.discussBookModel=[DBookModel mj_objectWithKeyValues:input];
    
    //广点通--插屏广告
    _interstitialObj = [[GDTMobInterstitial alloc] initWithAppId:GDTAppkey placementId:GDTPlacementIdC];
    _interstitialObj.delegate = self;
    [_interstitialObj loadAd];
    
    
   
    
}

//区头
-(void)initializeTableHeaderView{
    self.tableView.tableHeaderView = self.tableHeaderView;
    WEAKSELF
    self.tableHeaderView.waveView.waveBlock = ^(CGFloat currentY){
        
        CGRect iconFrame = [weakSelf.tableHeaderView.coverImageView frame];
        iconFrame.origin.y = CGRectGetHeight(weakSelf.tableHeaderView.coverImageView.frame)+currentY-30;
        weakSelf.tableHeaderView.coverImageView.frame  =iconFrame;
    };
    
}
//区尾
- (void)initializeTableFooterView
{
    WEAKSELF
    self.gridView = [BAGridView ba_creatGridViewWithGridViewConfig:self.ba_GridViewConfig block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
        [weakSelf didSelectRowAtIndexPath:indexPath];
    }];
    self.gridView.frame=CGRectMake(0, 0,kScreenWidth, kScreenHeight/4*3);
    self.tableView.tableFooterView = self.gridView;
}
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DBookModel *model         = self.gridDataArray[indexPath.row];
    [[DBookManager defaultManager] refreshBookModel:model];
    [self.tableHeaderView refreshUI];
    
    DBookTxtViewController*VC = [[DBookTxtViewController alloc] init];
    VC.bookModel=model;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 共享方法
    
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.gridDataArray removeAllObjects];
        [self.gridView.collectionView reloadData];
    }
    for (BmobObject *obj in input) {
        DBookModel *model    = [DBookModel new];
        [model modelDealWith:obj];
        [self.gridDataArray addObject:model];
    }
    self.gridView.dataArray=self.gridDataArray;
   
    if (![DBookManager defaultManager].bookID&&self.gridDataArray.count) {
        DBookModel *model   =self.gridDataArray[0];
        [[DBookManager defaultManager] refreshBookModel:model];
        [self.tableHeaderView refreshUI];
    }
    
}
//获取参数
-(BmobQuery *)getBmobQuery{
    NSString *className = @"Book";
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    [query orderByDescending:@"sequence"];
    query.limit = 9; //请求数量
    query.skip = self.gridDataArray.count;//跳过的数据
    return query;
}
- (NSMutableArray <DBookModel *> *)gridDataArray
{
    if (!_gridDataArray)
    {
        _gridDataArray = [NSMutableArray array];
        
    }
    return _gridDataArray;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.y;
    if (offset <= 0) {
        CGRect rect = self.tableHeaderView.bgImageView.frame;
        rect.origin.y = offset;
        rect.size.height = -offset + 240;
        self.tableHeaderView.bgImageView.frame = rect;
        
    }
}

// 广告预加载成功回调
//
// 详解:当接收服务器返回的广告数据成功后调用该函数
- (void)interstitialSuccessToLoadAd:(GDTMobInterstitial *)interstitial
{
    [_interstitialObj presentFromRootViewController:self];
}
- (DBookHeaderView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[DBookHeaderView alloc]init];
        _tableHeaderView.frame=CGRectMake(0, 0,kScreenWidth, 290);
    }
    return _tableHeaderView;
}
- (BAGridView_Config *)ba_GridViewConfig {
    if (!_ba_GridViewConfig) {
        _ba_GridViewConfig = [[BAGridView_Config alloc] init];
        _ba_GridViewConfig.gridViewType = BAGridViewTypeImageTitle;
        _ba_GridViewConfig.showLineView = NO;
        _ba_GridViewConfig.ba_gridView_rowCount = 3;
        _ba_GridViewConfig.ba_gridView_itemHeight = kScreenHeight/3;
        _ba_GridViewConfig.imgHeight=115;
        _ba_GridViewConfig.imgWidth=85;
        _ba_GridViewConfig.ba_gridView_itemImageInset = 0;
        _ba_GridViewConfig.ba_gridView_titleFont = AppFont(15);
        _ba_GridViewConfig.ba_gridView_backgroundColor = [UIColor whiteColor];
        
        
    }
    return _ba_GridViewConfig;
}
@end
