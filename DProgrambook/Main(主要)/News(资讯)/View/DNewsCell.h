//
//  DNewsCell.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/11.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNewsCell : DTableViewCell

/** 背景视图 */
@property(nonatomic,strong)UIView      *bgView;
/** 封面 */
@property(nonatomic,strong)UIImageView  *coverImageView;
/** 标题 */
@property(nonatomic,strong)UILabel     *titleLabel;
/** 介绍 */
@property(nonatomic,strong)UILabel     *introduceLabel;


@end

NS_ASSUME_NONNULL_END
