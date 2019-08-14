//
//  DNewsViewController.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/9.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DNewsViewController.h"
#import "DNewsHeaderView.h"
#import "DWebViewController.h"
#import "DNewsModel.h"
#import "DNewsCell.h"

@interface DNewsViewController ()

@property (nonatomic, strong) DNewsHeaderView *tableHeaderView;

@property (nonatomic, strong) NSMutableArray *bannerArray;

@end

@implementation DNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title=@"资讯";
    
    [self initializeRefresh];
    [self onHeaderRefreshing];
    
}
-(void)initializeData{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"information.json" ofType:nil];
    if (dataPath) {
        NSData *localData = [[NSData alloc] initWithContentsOfFile:dataPath];
        NSArray* localArray = [NSJSONSerialization JSONObjectWithData:localData options:0 error:nil];
        [self.bannerArray addObjectsFromArray:[DNewsModel mj_objectArrayWithKeyValuesArray:localArray]];
    }
}
//区头
-(void)initializeTableHeaderView{
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableHeaderView.urlImgs=self.bannerArray;
    [self.tableHeaderView.collectionView reloadData];
    WEAKSELF
    [self.tableHeaderView setClickBlock:^(NSInteger currentIndex) {
        DNewsModel *model = weakSelf.bannerArray[currentIndex];
        DWebViewController*VC=[[DWebViewController alloc]init];
        VC.newsModel=model;
        VC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    }];
    
}
#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
        [self.tableView  reloadData];
    }
    for (BmobObject *obj in input) {
        DNewsModel *model    = [DNewsModel new];
        [model modelDealWith:obj];
        [self.listArray addObject:model];
    }
    
    [self.tableView  reloadData];
    
}
//获取参数
-(BmobQuery *)getBmobQuery{
    NSString *className = @"Information";
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    query.limit = 6; //请求数量
    query.skip = self.listArray.count;//跳过的数据
    [query orderByDescending:@"updatedAt"];
    return query;
}
#pragma mark - 表格代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DNewsCell *cell = [DNewsCell cellWithTableView:tableView];
    DNewsModel *model = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DNewsModel *model   = self.listArray[indexPath.row];
    if (!model.cellHeight) {
        [model calculateHeight];
    }
    return model.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DNewsModel *model   = self.listArray[indexPath.row];
    DWebViewController*VC=[[DWebViewController alloc]init];
    VC.newsModel=model;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
- (DNewsHeaderView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView =[[DNewsHeaderView alloc] initWithFrame:CGRectMake(0, 100,kScreenWidth, 160) line:15.0 showLine: 10.0 cellMidSize:CGSizeMake(kScreenWidth-50, 110.0) zoom:0.8];
       
        _tableHeaderView.cellCornerRadius = 4;
        _tableHeaderView.placeHolderImage = ImageNamed(@"mohu");
    }
    return _tableHeaderView;
}
- (NSMutableArray *)bannerArray {
    if (_bannerArray == nil) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

@end
