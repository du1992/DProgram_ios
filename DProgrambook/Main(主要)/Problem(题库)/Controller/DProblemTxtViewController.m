//
//  DProblemTxtViewController.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DProblemTxtViewController.h"
#import "DProblemTxtHeaderView.h"
#import "DProblemTxtCell.h"
#import "DProblemTxtModel.h"

@interface DProblemTxtViewController ()

@property (nonatomic, strong) DProblemTxtHeaderView   *tableHeaderView;

@end

@implementation DProblemTxtViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
   
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.tableView.backgroundColor=UIColorFromRGBValue(0xF6F6F6);
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top = (IS_iPhoneX ? -45 : -25);
    [self.tableView setContentInset:contentInset];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    [self initializeDataModel];
    
}
-(void)initializeDataModel{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.json",self.problemModel.problemID] ofType:nil];
        if (dataPath) {
            NSData *localData = [[NSData alloc] initWithContentsOfFile:dataPath];
            NSArray* localArray = [NSJSONSerialization JSONObjectWithData:localData options:0 error:nil];
            [self.listArray addObjectsFromArray:[DProblemTxtModel mj_objectArrayWithKeyValuesArray:localArray]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
               [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self.tableView  reloadData];
            
        });});
    
    
    
  
}
//区头
-(void)initializeTableHeaderView{
    self.tableView.tableHeaderView = self.tableHeaderView;
    [self.tableHeaderView setData:self.problemModel];
    [self.tableHeaderView.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 表格代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DProblemTxtCell *cell = [DProblemTxtCell cellWithTableView:tableView];
    DProblemTxtModel *model = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DProblemTxtModel *model   = self.listArray[indexPath.row];
    if (!model.cellHeight) {
        [model calculateHeight];
    }
    return model.cellHeight;
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
- (DProblemTxtHeaderView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[DProblemTxtHeaderView alloc]init];
        _tableHeaderView.frame=CGRectMake(0, 0,kScreenWidth, 320);
    }
    return _tableHeaderView;
}

@end
