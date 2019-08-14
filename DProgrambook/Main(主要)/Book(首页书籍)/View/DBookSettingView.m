//
//  DBookSettingView.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/3.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBookSettingView.h"
@implementation DBookSettingManager

-(void)initializeView:(UIView*)parentView{
    self.topView.frame=CGRectMake(0, 0,kScreenWidth,64);
    [parentView addSubview:self.topView];
    
    self.bottomView.frame=CGRectMake(0,kScreenHeight-50,kScreenWidth, 50);
    [parentView addSubview:self.bottomView];
    
   
    if ([DBookManager defaultManager].isMoon) {
          [self.bottomView.colorButton setImage:[UIImage imageNamed:@"readerSun"] forState:UIControlStateNormal];
    }else{
          [self.bottomView.colorButton setImage:[UIImage imageNamed:@"readerMoon"] forState:UIControlStateNormal];
    }
    
   
    
    
}
//颜色
-(void)colorTapClick{
    if (self.onSettingViewDidChangeColor) {
        [DBookManager defaultManager].isMoon=![DBookManager defaultManager].isMoon;
        if ([DBookManager defaultManager].isMoon) {
            [self.bottomView.colorButton setImage:[UIImage imageNamed:@"readerSun"] forState:UIControlStateNormal];
        }else{
            [self.bottomView.colorButton setImage:[UIImage imageNamed:@"readerMoon"] forState:UIControlStateNormal];
        }
        self.onSettingViewDidChangeColor();
    }
}
//设置
-(void)settingTapClick{
    if (self.onSettingViewDidChange) {
        self.onSettingViewDidChange();
    }
    
}
//返回
-(void)leftTapClick{
    if (self.onSettingViewDidChangeReturn) {
        self.onSettingViewDidChangeReturn();
    }
}
//章节菜单
-(void )rightTapClick{
    if (self.onSettingViewDidChangeChapter) {
        self.onSettingViewDidChangeChapter();
    }
}
-(DBookSettingTopView*)topView{
    if (!_topView) {
        _topView=[[DBookSettingTopView alloc]init];
        _topView.backgroundColor= UIColorFromRGBValue(0xF7F7F7);
        [_topView.leftButton addTarget:self action:@selector(leftTapClick) forControlEvents:UIControlEventTouchUpInside];
        [_topView.rightButton addTarget:self action:@selector(rightTapClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topView;
}
-(DBookSettingBottomView*)bottomView{
    if (!_bottomView) {
        _bottomView=[[DBookSettingBottomView alloc]init];
         _bottomView.backgroundColor= UIColorFromRGBValue(0xF7F7F7);
        [_bottomView.colorButton addTarget:self action:@selector(colorTapClick) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.settingButton addTarget:self action:@selector(settingTapClick) forControlEvents:UIControlEventTouchUpInside];
    }
   return _bottomView;
}


/**
 *  点击按钮弹出
 */
-(void)show{
    if (self.topView.hidden) {
        self.topView.hidden=NO;
        self.bottomView.hidden=NO;
        [UIView animateWithDuration: 0.35 animations: ^{
            self.topView.frame=CGRectMake(0, 0,kScreenWidth,64);
            self.bottomView.frame=CGRectMake(0,kScreenHeight-50,kScreenWidth,50);
        } completion:^(BOOL finished) {
        }];
    }
    
}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss{
    if (!self.topView.hidden) {
        [UIView animateWithDuration: 0.35 animations: ^{
            self.topView.frame=CGRectMake(0,-64,kScreenWidth,64);
            self.bottomView.frame=CGRectMake(0,kScreenHeight,kScreenWidth,50);
        } completion:^(BOOL finished) {
            self.topView.hidden=YES;
            self.bottomView.hidden=YES;
        }];
    }
}

@end





@implementation DBookSettingTopView

-(void)setLayout{
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(15,30));
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(15);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(28,28));
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftButton.mas_right).offset(10);
        make.right.mas_equalTo(self.rightButton.mas_left).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(30);
    }];
    
    
}
-(UIButton*)leftButton{
    if (!_leftButton) {
        _leftButton=[UIButton new];
        [_leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
        [self addSubview:_leftButton];
    }
    return _leftButton;
}

-(UIButton*)rightButton{
    if (!_rightButton) {
        _rightButton=[UIButton new];
        [_rightButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [self addSubview:_rightButton];
    }
    return _rightButton;
}
  
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
    
    
@end














@implementation DBookSettingBottomView

-(void)setLayout{
    [self.colorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2,40));
        make.centerY.mas_equalTo(self.mas_centerY);
       make.left.mas_equalTo(self.mas_left).offset(0);
        
    }];
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2,40));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(0);
    }];
    
    
}
-(UIButton*)colorButton{
    if (!_colorButton) {
        _colorButton=[UIButton new];
        [_colorButton setImage:[UIImage imageNamed:@"readerMoon"] forState:UIControlStateNormal];
        [self addSubview:_colorButton];
    }
    return _colorButton;
}

-(UIButton*)settingButton{
    if (!_settingButton) {
        _settingButton=[UIButton new];
        [_settingButton setImage:[UIImage imageNamed:@"readerSettin"] forState:UIControlStateNormal];
       [self addSubview:_settingButton];
    }
    return _settingButton;
}
@end
