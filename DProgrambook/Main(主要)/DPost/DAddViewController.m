//
//  DAddViewController.m
//  Dprogramming
//
//  Created by DUCHENGWEN on 2017/12/17.
//  Copyright © 2017年 kevindcw. All rights reserved.
//

#import "DAddViewController.h"
#import "DCustomPlaceHolderTextView.h"
#import "DPublishDraftBottomView.h"


@interface DAddViewController ()<DCustomPlaceHolderTextViewDelegate,DPublishDraftBottomViewDelegate>
/** 输入框*/
@property (nonatomic, weak) DCustomPlaceHolderTextView *placeHolderTextView;
/** 底部视图*/
@property (nonatomic, weak) DPublishDraftBottomView *bottomView;

@property (nonatomic, assign) CGFloat bottomViewY;
@property (nonatomic, weak) UIScrollView *scrollView;
/** 是否为匿名*/
@property (nonatomic, assign) BOOL isAnonymous;
@end

@implementation DAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItem];
    self.view.backgroundColor = AppColor(240, 244, 247);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightItem)];
    [rightItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.title=@"发帖子";
    
    
    
    // 2. 设置子视图
    [self setLayout];
    
    [self addBackItem];
    
   
    

}
-(void)rightItem{
     [self.placeHolderTextView resignFirstResponder];
    if (self.placeHolderTextView.text.length == 0) {
        DCustomAlertView *alert = [[DCustomAlertView alloc] initWithTitle:@"文本内容不能为空" cancel:nil sure:@"确定"];
        [alert showInView:self.view.window];
        return ;
    }
    if (self.placeHolderTextView.text.length >300) {
        DCustomAlertView *alert = [[DCustomAlertView alloc] initWithTitle:@"文本内容不能大于300个字符" cancel:nil sure:@"确定"];
        [alert showInView:self.view.window];
        return ;
    }
  
    
        BmobUser*bUser = [BmobUser currentUser];
        BmobObject *obj = [[BmobObject alloc] initWithClassName:@"DPost"];
        NSString*userLogo=[DInterfaceUrl getImgString:[bUser objectForKey:@"userLogo"]];
        [obj setObject:self.placeHolderTextView.text forKey:@"content"];
    
        [obj setObject:bUser.objectId forKey:@"authorID"];
        [obj setObject:[bUser objectForKey:@"nickName"]   forKey:@"nickName"];
        [obj setObject:userLogo   forKey:@"userLogo"];
        [obj setObject:[NSString stringWithFormat:@"%d",_isAnonymous]     forKey:@"isAnonymous"];
    
  
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            
            if (!error) {
                NSLog(@"提交成功");
                [self.view showLoadingMeg:@"提交成功" time:kDefaultShowTime];
                //延迟加载
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                       [self performSelector:@selector(backAction) withObject:nil afterDelay:1];
                    });
                });
               
            }else{
                [self.view showLoadingMeg:@"提交失败" time:kDefaultShowTime];
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil
                                                                    message:[[error userInfo] objectForKey:@"error"]
                                                                   delegate:nil
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"ok", nil];
                [alertview show];
            }
            
        }];
        
}



// 设置子视图
- (void)setLayout{
    // 设置占位文字
    self.placeHolderTextView.placehoder = @"请填写您的发帖内容！敬告：请不要发布色情敏感内容";
    self.placeHolderTextView.placeholderFont = AppFont(13);
    
    // 设置底部视图
    self.bottomViewY = kScreenWidth - 64;
    self.bottomView.limitCount = 300;
    self.bottomView.backgroundColor = [UIColor whiteColor];
}

// 添加通知
- (void)setUpNotis {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiddenNoti:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowNoti:) name:UIKeyboardWillShowNotification object:nil];
    
   
}

- (DCustomPlaceHolderTextView *)placeHolderTextView {
    if (!_placeHolderTextView) {
        DCustomPlaceHolderTextView *placeHolderTextView = [[DCustomPlaceHolderTextView alloc] init];
        [self.scrollView addSubview:placeHolderTextView];
        _placeHolderTextView = placeHolderTextView;
        placeHolderTextView.placeholderFont = AppFont(14);
        placeHolderTextView.del = self;
       
        [placeHolderTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.width.mas_equalTo(self.view.width);
            make.top.mas_equalTo(self.view).offset(64);
            make.height.mas_equalTo(200);
        }];
    }
    return _placeHolderTextView;
}
- (DPublishDraftBottomView *)bottomView {
    if (!_bottomView) {
        DPublishDraftBottomView *bottomView = [[DPublishDraftBottomView alloc] init];
        [self.view addSubview:bottomView];
        _bottomView = bottomView;
        bottomView.delegate = self;
       
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.view);
            make.height.mas_equalTo(80);
            make.top.mas_equalTo(kScreenWidth  - 80);
        }];
    }
    return _bottomView;
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *sc = [[UIScrollView alloc] init];
        [self.view addSubview:sc];
        _scrollView = sc;
        
        [sc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        sc.showsVerticalScrollIndicator = NO;
        sc.showsHorizontalScrollIndicator = NO;
        sc.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}
// 键盘下落
- (void)keyBoardWillHiddenNoti:(NSNotification *)noti {
    [self configKeyBoardWithHidden:YES userInfo:noti.userInfo];
}

// 键盘生起
- (void)keyBoardWillShowNoti:(NSNotification *)noti {
    [self configKeyBoardWithHidden:NO userInfo:noti.userInfo];
}

- (void)configKeyBoardWithHidden:(BOOL)hidden userInfo:(id)userInfo {
    if (userInfo == nil) return ;
    CGRect endRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomViewY = kScreenWidth - 80 - (hidden ? 0 : endRect.size.height);
    
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)updateViewConstraints {
    [super updateViewConstraints];

    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(80);
        make.top.mas_equalTo(self.bottomViewY);
    }];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.placeHolderTextView.bottom + 10);
   
}

#pragma mark - NHCustomPlaceHolderTextViewDelegate
- (void)customPlaceHolderTextViewTextDidChange:(DCustomPlaceHolderTextView *)textView {
    NSString *text = textView.text;
    
    if (text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
        self.bottomView.limitCount = 0;
    } else {
        self.bottomView.limitCount = 300 - text.length;
    }
}

#pragma mark - NHPublishDraftBottomViewDelegate
- (void)publishDraftBottomView:(DPublishDraftBottomView *)bottomView didClickItemWithType:(DPublishDraftBottomViewItemType)type {
    
    switch (type) {
        case DPublishDraftBottomViewItemTypePicture: { // 添加图片
            [self.placeHolderTextView resignFirstResponder];
//            [self addImage];
        }
            break;
            
        case DPublishDraftBottomViewItemTypeVideo: { // 添加视频
            [self.placeHolderTextView resignFirstResponder];
//            [self addVideo];
        }
            break;
            // 匿名
        case DPublishDraftBottomViewItemTypeAnonymous: {
            self.isAnonymous = !self.isAnonymous;
        }
            break;
        default:
            break;
    }
}


@end
