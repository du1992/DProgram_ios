//
//  DNewsCell.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/11.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DNewsCell.h"
#import "DNewsModel.h"

@implementation DNewsCell

-(void)setLayout{
    
     self.backgroundColor=UIColorFromRGBValue(0xF6F6F6);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0,5, 0));
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        make.top.mas_equalTo(self.bgView.mas_top).offset(20);
        make.height.mas_equalTo(120);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(15);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);

    }];
}

-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_bgView];
    }
    return _bgView;
}
-(UIImageView*)coverImageView{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode=UIViewContentModeScaleAspectFill;
        _coverImageView.layer.cornerRadius=4;
        _coverImageView.clipsToBounds = YES;
        [_bgView addSubview:_coverImageView];
    }
    return _coverImageView;
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = AppFont(16);
        [_bgView addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UILabel*)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc]init];
        _introduceLabel.font = AppFont(16);
        _introduceLabel.textColor=[UIColor grayColor];
        _introduceLabel.numberOfLines   = 0;
        [_bgView addSubview:_introduceLabel];
    }
    return _introduceLabel;
}


-(void)setData:(DNewsModel *)model{
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.captions] placeholderImage:ImageNamed(@"mohu")];
    self.titleLabel.text=model.title;
    self.introduceLabel.text=model.about;
    
    
    
}


@end
