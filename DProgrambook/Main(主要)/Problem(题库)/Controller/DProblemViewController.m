//
//  DProblemViewController.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/7/31.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DProblemViewController.h"
#import "DProblemHeaderView.h"
#import "DProblemCell.h"
#import "DProblemModel.h"
#import "DProblemTxtViewController.h"

@interface DProblemViewController ()

@property (nonatomic, strong) DProblemHeaderView   *tableHeaderView;

@end

@implementation DProblemViewController
- (void)viewDidAppear:(BOOL)animated{
    [TableViewAnimationKit showWithAnimationType:5 tableView:self.tableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"题库";
    
    self.tableView.backgroundColor=UIColorFromRGBValue(0xF6F6F6);
    
}
-(void)initializeData{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Problem.json" ofType:nil];
    if (dataPath) {
        NSData *localData = [[NSData alloc] initWithContentsOfFile:dataPath];
       NSArray* localArray = [NSJSONSerialization JSONObjectWithData:localData options:0 error:nil];
        [self.listArray addObjectsFromArray:[DProblemModel mj_objectArrayWithKeyValuesArray:localArray]];
    }
}
//区头
-(void)initializeTableHeaderView{
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    
}
#pragma mark - 表格代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DProblemCell *cell = [DProblemCell cellWithTableView:tableView];
    DProblemModel *model = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 95;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DProblemModel *model = self.listArray[indexPath.row];
    DProblemTxtViewController*VC=[DProblemTxtViewController new];
    VC.problemModel=model;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}
- (DProblemHeaderView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[DProblemHeaderView alloc]init];
        _tableHeaderView.frame=CGRectMake(0, 0,kScreenWidth, 200);
    }
    return _tableHeaderView;
}
@end
