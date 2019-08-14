//
//  DBookTxtCell.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/3.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBookTxtCell : DTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *txtLabel;

@end

NS_ASSUME_NONNULL_END
