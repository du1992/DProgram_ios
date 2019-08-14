//
//  DPostViewController.m
//  Dprogramming
//
//  Created by DUCHENGWEN on 2017/12/16.
//  Copyright © 2017年 kevindcw. All rights reserved.
//

#import "DPostViewController.h"
#import "DPostTableViewCell.h"
#import "DAddViewController.h"

#import "DPostModel.h"
#import "GDTMobBannerView.h"



@interface DPostViewController ()<GDTMobBannerViewDelegate>{
    
    BOOL                 isBanRefresh;
    GDTMobBannerView    *bannerView;
    NSDateFormatter     *_dateFormatter;
}



@end

@implementation DPostViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"帖子";
  
    
  
    [self addRightBarButtonItem:ImageNamed(@"编辑")];
    
    [self initializeRefresh];
    [self onHeaderRefreshing];
    [self GDTadvertising];
   
    self.tableView.frame=CGRectMake(0, 50, kScreenWidth, kScreenHeight-50);
    
    
 

    
    
}

-(void)rightItemClick{
    DAddViewController*soVC=[DAddViewController new];
    soVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:soVC animated:YES];
}

#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
        [self.tableView  reloadData];
    }
    for (BmobObject *obj in input) {
        DPostModel *model    = [DPostModel new];
        [model modelDealWith:obj];
        [self.listArray addObject:model];
    }
    
    [self.tableView  reloadData];
    
}
//获取参数
-(BmobQuery *)getBmobQuery{
    NSString *className = @"DPost";
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    query.limit = 16; //请求数量
    query.skip = self.listArray.count;//跳过的数据
    [query orderByDescending:@"updatedAt"];
    return query;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 20;
    }
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:AppAlphaColor(242, 242, 242, 0.6)];
    return contentView;
}
#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
    {
        CGFloat viewWidth= (SCREEN_WIDTH-60)/2;
        return viewWidth*0.58+50;
    }
    else{
        DPostModel *model   = self.listArray[indexPath.row];
        if (!model.cellHeight) {
            [model calculateHeight];
        }
        return model.cellHeight;
  
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section == 0)
    {
          return 1;
    }else{
         return self.listArray.count;
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DHotRecommendCell*cell = [DHotRecommendCell cellWithTableView:tableView];
        WEAKSELF
        cell.clickPushView =^(DPushViewType type){
             [weakSelf.view showLoadingMeg:@"功能未开放" time:kDefaultShowTime];
            if (type==DPushViewTypeVideo) {
               
            }else if (type==DPushViewTypeAudio){
               
            }
        };
        
        
        return cell;
        
        
    }else{
        
        DPostTableViewCell *cell = [DPostTableViewCell cellWithTableView:tableView];
        DPostModel *model = self.listArray[indexPath.row];
        [cell setData:model];
        return cell;
        
        
    }
    
    
    
    
    
}


#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
       
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (cell.tag!=100) {
        cell.tag=100;
        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, 0, 0, 0, 1);//渐变
        transform = CATransform3DTranslate(transform, 0, -50, 0);//左边水平移动
        transform = CATransform3DScale(transform, 0, 0, 0);//由小变大
        cell.layer.transform = transform;
        cell.layer.opacity = 0.0;
        [UIView animateWithDuration:0.5 animations:^{
            cell.layer.transform = CATransform3DIdentity;
            cell.layer.opacity = 1;
        }];
    }
 
}

-(void)GDTadvertising{
    
    bannerView = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,50)
                                                  appId:GDTAppkey placementId:GDTPlacementIdD];
    
    
    if (IS_OS_7_OR_LATER) {
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
    
    bannerView.delegate = self;
    bannerView.currentViewController = self;
    //    bannerView.isAnimationOn = NO;
    //    bannerView.showCloseBtn = NO;
    bannerView.isGpsOn = YES;
    [bannerView loadAdAndShow];
    [self.view addSubview:bannerView];
}

- (void)bannerViewMemoryWarning
{
    NSLog(@"did receive memory warning");
}

// 请求广告条数据成功后调用
//
// 详解:当接收服务器返回的广告数据成功后调用该函数
- (void)bannerViewDidReceived
{
    
}
/**
 *  banner条被用户关闭时调用
 *  详解:当打开showCloseBtn开关时，用户有可能点击关闭按钮从而把广告条关闭
 */
- (void)bannerViewWillClose{
    
   
}
// 请求广告条数据失败后调用
//
// 详解:当接收服务器返回的广告数据失败后调用该函数
- (void)bannerViewFailToReceived:(NSError *)error
{
    NSLog(@"banner failed to Received : %@",error);
}

// 广告栏被点击后调用
//
// 详解:当接收到广告栏被点击事件后调用该函数
- (void)bannerViewClicked
{
    NSLog(@"banner clicked");
}

// 应用进入后台时调用
//
// 详解:当点击下载或者地图类型广告时，会调用系统程序打开，
// 应用将被自动切换到后台
- (void)bannerViewWillLeaveApplication
{
    NSLog(@"banner leave application");
}


@end
