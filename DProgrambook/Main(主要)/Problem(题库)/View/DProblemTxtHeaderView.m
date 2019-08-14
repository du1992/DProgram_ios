//
//  DProblemTxtHeaderView.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DProblemTxtHeaderView.h"
#import "DProblemModel.h"
@implementation DProblemTxtHeaderView

-(void)setLayout{
    
    self.bgImageView.frame=CGRectMake(0,0,kScreenWidth,200);
 
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(50);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(35);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(self.mas_left).offset(15);
    }];
    
    [self.introduceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(90);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-30, 120));
    }];
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.mas_equalTo(self.introduceView).insets(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
    
    [self.segmentationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth,(kScreenWidth)*0.01));
    }];
    
    
    
    
 
   
}

-(UIImageView*)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
        _bgImageView.image=ImageNamed(@"mohu");
        [self addSubview:_bgImageView];
    }
    return _bgImageView;
}
-(UIImageView*)segmentationImageView{
    if (!_segmentationImageView) {
        _segmentationImageView = [[UIImageView alloc] init];
        _segmentationImageView.image=ImageNamed(@"segmentation");
        [self addSubview:_segmentationImageView];
    }
    return _segmentationImageView;
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = AppBoldFont(20);
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.text  =@"";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.shadowColor = [UIColor blackColor];
        _titleLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
-(UIView*)introduceView{
    if (!_introduceView) {
        _introduceView = [[UIView alloc] init];
        _introduceView.layer.shadowColor =UIColorFromRGBValue(0xDCDCDC).CGColor;
        _introduceView.layer.shadowOffset = CGSizeMake(0, 1);
        _introduceView.layer.shadowOpacity = 0.3;
        _introduceView.layer.shadowRadius = 4.0;
        _introduceView.layer.cornerRadius = 5.0;
        _introduceView.clipsToBounds = NO;
        _introduceView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_introduceView];
    }
    return _introduceView;
}
-(UILabel*)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc]init];
        _introduceLabel.font = AppFont(15);
        _introduceLabel.textAlignment = NSTextAlignmentCenter;
        _introduceLabel.numberOfLines   = 0;
        [self.introduceView addSubview:_introduceLabel];
    }
    return _introduceLabel;
}
-(UIButton*)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_backButton];
        [_backButton setImage:[UIImage imageNamed:@"Path"] forState:UIControlStateNormal];
    }
    return _backButton;
}
-(void)setData:(DProblemModel *)model{
    self.titleLabel.text=model.honor;
    self.introduceLabel.text=model.introduce;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.backgroundImg] placeholderImage:ImageNamed(@"mohu")];
}
@end
