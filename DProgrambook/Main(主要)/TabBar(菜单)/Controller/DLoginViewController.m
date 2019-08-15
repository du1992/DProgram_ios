//
//  DLoginViewController.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/14.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DLoginViewController.h"
#import "DShowPropView.h"
#import "DButton.h"
#import "AppDelegate.h"

@interface DLoginViewController ()

@property (nonatomic, strong)   UIImageView     *bgImageView;
@property (nonatomic, strong)   DShowPropView   *showPropView;
@end

@implementation DLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setLayout];
    
    
  
}
-(void)setLayout{
    self.bgImageView.frame=self.view.frame;
    
    DPropsModel *PropsModel=[DPropsModel new];
    PropsModel.idString=@"0";
    [self.showPropView didReceiveProp:PropsModel];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    titleLabel.center = CGPointMake(self.view.center.x, 150);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"编程管家";
    titleLabel.font = [UIFont systemFontOfSize:38.f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    DButton*registered = [[DButton alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    [registered setTitle:@"一键登录" font:[UIFont systemFontOfSize:16.f] titleColor:[UIColor whiteColor]];
    registered.center = CGPointMake(self.view.center.x,kScreenHeight-150);
    registered.dynamicColor=[UIColor whiteColor];
    
    
    registered.layer.cornerRadius=10;
    registered.clipsToBounds = YES;
    registered.layer.borderColor = [UIColor whiteColor].CGColor;
    registered.layer.borderWidth = 1.0;
    [self.view addSubview:registered];
    WEAKSELF
    registered.translateBlock = ^{
        [registered startAllAnimation:nil];
        [DInterfaceUrl userPopupWindowBlock:^(BOOL isSuccessful, NSError *error) {
                    [registered removeAllAnimation];
            if (isSuccessful) {
                [[AppDelegate sharedAppDelegate] enterMainUI];
            }else{
                 [weakSelf.view showLoadingMeg:@"登录失败" time:kDefaultShowTime];
            }
        }];

    };
}
//背景动画
-(DShowPropView*)showPropView{
    if (!_showPropView) {
        self.showPropView = [[DShowPropView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) bottomSpace:0];
        self.showPropView.logicView=self.view;
        self.showPropView.backgroundColor=AppAlphaColor(0, 0, 0, 0.1);
        [self.view addSubview:self.showPropView];
    }
    return _showPropView;
}
-(UIImageView*)bgImageView{
    if (!_bgImageView) {
        _bgImageView=[UIImageView new];
        _bgImageView.contentMode=UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
        _bgImageView.image=ImageNamed(@"HY4");
        [self.view addSubview:_bgImageView];
    }
    return _bgImageView;
}


@end
