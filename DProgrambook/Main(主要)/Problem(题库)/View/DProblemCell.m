//
//  DProblemCell.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DProblemCell.h"
#import "DProblemModel.h"

@implementation DProblemCell

-(void)setLayout{
    
    self.backgroundColor=UIColorFromRGBValue(0xF6F6F6);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(80);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(15);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        make.width.mas_equalTo(kScreenWidth-100);
    }];
    
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        make.width.mas_equalTo(kScreenWidth-100);
    }];
    
    [self.indicatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.shadowColor =UIColorFromRGBValue(0xDCDCDC).CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(0, 1);
        _bgView.layer.shadowOpacity = 0.3;
        _bgView.layer.shadowRadius = 4.0;
        _bgView.layer.cornerRadius = 5.0;
        _bgView.clipsToBounds = NO;
        _bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_bgView];
    }
    return _bgView;
}
-(UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
      
       [_bgView addSubview:_iconImageView];
    }
    return _iconImageView;
}
-(UIImageView*)indicatorImageView{
    if (!_indicatorImageView) {
        _indicatorImageView = [[UIImageView alloc] init];
        _indicatorImageView.image=ImageNamed(@"point");
        [_bgView addSubview:_indicatorImageView];
    }
    return _indicatorImageView;
}
-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = AppFont(18);
        [_bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UILabel*)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc]init];
        _introduceLabel.font = AppFont(15);
        _introduceLabel.textColor=[UIColor grayColor];
        [_bgView addSubview:_introduceLabel];
    }
    return _introduceLabel;
}

-(void)setData:(DProblemModel *)model{
    self.iconImageView.image=[UIImage imageNamed:model.problemID];
    self.titleLabel.text=model.title;
    self.introduceLabel.text=model.directions;
}

@end
