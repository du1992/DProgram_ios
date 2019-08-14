//
//  DBookTxtCell.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/3.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBookTxtCell.h"
#import "DBookTxtModel.h"


@implementation DBookTxtCell

- (void)setLayout{
    self.backgroundColor= [UIColor clearColor];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(10);
    }];
    
    [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
}
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UITextView *)txtLabel{
    
    if (!_txtLabel) {
         _txtLabel = [[UITextView alloc] init];
        _txtLabel.userInteractionEnabled=NO;
        _txtLabel.backgroundColor= [UIColor clearColor];
         _txtLabel.textContainer.lineFragmentPadding = 0;
        [self addSubview:_txtLabel];
    }
    return _txtLabel;
}

-(void)setData:(DBookTxtModel *)model
{
    
    self.titleLabel.text=model.title;

    self.txtLabel.text=model.txt;

   
    
    
    
    
    _titleLabel.font = [[DBookManager defaultManager] getTitleFontSize];
    _txtLabel.font = [[DBookManager defaultManager] getTxtFontSize];
    
    if ([DBookManager defaultManager].isMoon) {
        _txtLabel.textColor=[UIColor whiteColor];
        _titleLabel.textColor=[UIColor whiteColor];
    }else{
        _txtLabel.textColor=AppColor(116, 120, 126);
        _titleLabel.textColor=AppColor(140, 146, 156);
    }
    
}

@end
