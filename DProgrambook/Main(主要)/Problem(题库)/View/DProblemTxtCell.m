//
//  DProblemTxtCell.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DProblemTxtCell.h"
#import "DProblemTxtModel.h"

@implementation DProblemTxtCell

-(void)setLayout{
    
    self.backgroundColor=UIColorFromRGBValue(0xF6F6F6);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(20, 10, 20, 10));
    }];
    
    
    [self.questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
    }];
    
    [self.answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-10);
        make.top.mas_equalTo(self.questionLabel.mas_bottom).offset(16);
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

-(UILabel*)questionLabel{
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc]init];
        _questionLabel.font = AppFont(18);
        _questionLabel.textColor=[UIColor grayColor];
        _questionLabel.numberOfLines   = 0;
        [_bgView addSubview:_questionLabel];
    }
    return _questionLabel;
}
-(UILabel*)answerLabel{
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc]init];
        _answerLabel.font = AppFont(16);
        _answerLabel.numberOfLines   = 0;
        [_bgView addSubview:_answerLabel];
    }
    return _answerLabel;
}
-(void)setData:(DProblemTxtModel *)model{
   
    self.questionLabel.text=model.question;
    self.answerLabel.text=model.answer;
}
@end
