//
//  DProblemHeaderView.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DProblemHeaderView.h"

@implementation DProblemHeaderView

-(void)setLayout{
    
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-15);
        
    }];
}

-(UIImageView*)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.cornerRadius=3;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.image=ImageNamed(@"icon");
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

-(UILabel*)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel = [[UILabel alloc]init];
        _introduceLabel.font = AppFont(15);
        _introduceLabel.textAlignment = NSTextAlignmentCenter;
        _introduceLabel.numberOfLines   = 0;
        _introduceLabel.text=@"基础不太好?概念不清?那还不来复习一下，收集各大公司的面试题库供小伙伴儿们复习,学习,巩固👇";
        [self addSubview:_introduceLabel];
    }
    return _introduceLabel;
}


@end
