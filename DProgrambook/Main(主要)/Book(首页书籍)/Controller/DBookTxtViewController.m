//
//  DBookTxtViewController.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/2.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBookTxtViewController.h"
#import "DBookTxtModel.h"
#import "DBookTxtCell.h"
#import "DBookSettingView.h"
#import "DReaderSettingView.h"
#import "DChapterView.h"

@interface DBookTxtViewController ()

@property(nonatomic,strong) DBookSettingManager*bookSettingManager;
@property(nonatomic,strong) DReaderSettingView *settingView;
@property (nonatomic,strong) DChapterView *chapterView;

@property (nonatomic) NSInteger chapterIndex;

@property (nonatomic) BOOL isChapterSelected;
@end

@implementation DBookTxtViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    if (!self.bookModel.isLocal) {
        [self onHeaderRefreshing];
    }
    

    self.tableView.backgroundColor= [UIColor clearColor];
    
    
  
    self.view.backgroundColor=UIColorHex([[DBookManager defaultManager]getbgColor]);
    
    
    [self.bookSettingManager initializeView:self.view];
    
    NSLog(@"%@",self.bookModel.chapterArray);
    
    
   
    WEAKSELF
    self.settingView.onSettingViewDidChangeBgColor = ^{
        //设置背景
         weakSelf.view.backgroundColor=UIColorHex([[DBookManager defaultManager]getbgColor]);
    };
    self.settingView.onSettingViewDidChangeFontSize = ^{
        //设置字号
        [weakSelf resetTxtView];
    };
    
    self.bookSettingManager.onSettingViewDidChangeColor = ^{
        //设置夜间模式
         weakSelf.view.backgroundColor=UIColorHex([[DBookManager defaultManager]getbgColor]);
        [weakSelf.tableView  reloadData];
    };
    self.bookSettingManager.onSettingViewDidChange = ^{
        //开启设置
        [weakSelf.settingView show];
    };
    self.bookSettingManager.onSettingViewDidChangeReturn = ^{
        //返回
        [weakSelf backAction];
    };
    self.bookSettingManager.onSettingViewDidChangeChapter = ^{
      //章节
        
        
        weakSelf.chapterView.listArray=weakSelf.bookModel.chapterArray;
        [weakSelf.chapterView show];
    };
    self.chapterView.onChooseMusicUpdateTata = ^(NSInteger curIndex) {
        weakSelf.isChapterSelected=YES;
        weakSelf.chapterIndex=curIndex;
        [weakSelf onHeaderRefreshing];
    };
    
    
   
}

#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
         [self.tableView  reloadData];
    }
    for (BmobObject *obj in input) {
        DBookTxtModel *model    = [DBookTxtModel new];
        [model modelDealWith:obj];
        [self.listArray addObject:model];
        
        if (self.isChapterSelected) {
            self.isChapterSelected=NO;
            [[DBookManager defaultManager]refreshBookTxtModel:model index:self.chapterIndex];
        }
    }
    
    [self.tableView  reloadData];
    
}
//获取参数
-(BmobQuery *)getBmobQuery{
    NSString *className = @"BookText";
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    [query orderByDescending:@"sequence"];
    [query whereKey:@"bookID" equalTo:self.bookModel.bookID];
    query.limit = 10; //请求数量
    query.skip = self.listArray.count;//跳过的数据
    return query;
}
#pragma mark - 表格代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    DBookTxtCell *cell = [DBookTxtCell cellWithTableView:tableView];
    DBookTxtModel *model = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBookTxtModel *model   = self.listArray[indexPath.row];
    if (!model.cellHeight) {
        [model calculateHeight];
    }
    return model.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [self.settingView dismiss];
    
    if (self.bookSettingManager.topView.hidden) {
        [self.bookSettingManager show];
    }else{
       [self.bookSettingManager dismiss];
    }
    
}
//视图滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     [self.settingView dismiss];
    if (!self.bookSettingManager.topView.hidden) {
        [self.bookSettingManager dismiss];
    }
}

-(DBookSettingManager*)bookSettingManager{
    if (!_bookSettingManager) {
        _bookSettingManager=[[DBookSettingManager alloc]init];
         _bookSettingManager.topView.titleLabel.text=self.bookModel.titleString;
    }
    return _bookSettingManager;
}
-(DReaderSettingView*)settingView{
    if (!_settingView) {
        _settingView = [DReaderSettingView viewFromNib];
        [self.view addSubview:_settingView];
        _settingView.backgroundColor= UIColorFromRGBValue(0xF7F7F7);
        _settingView.collectionView.backgroundColor=UIColorFromRGBValue(0xF7F7F7);
        _settingView.frame=CGRectMake(0, kScreenHeight, kScreenWidth,250);
        _settingView.hidden=YES;
    }
    return _settingView;
}
-(DChapterView*)chapterView{
    if (!_chapterView) {
        _chapterView=[[DChapterView alloc]init];
        _chapterView.frame= CGRectMake(0,0,kScreenWidth,kScreenHeight);
         [self.view addSubview:_chapterView];
    }
    return _chapterView;
}


-(void)resetTxtView{
    for (DBookTxtModel *model in self.listArray) {
        [model calculateHeight];
    }
    [self.tableView  reloadData];
}


@end
