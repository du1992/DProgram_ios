//
//  DProblemHeaderView.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"

NS_ASSUME_NONNULL_BEGIN
 
@interface DProblemHeaderView : DView

/** 图标 */
@property(nonatomic,strong)UIImageView  *iconImageView;

/** 介绍 */
@property(nonatomic,strong)UILabel     *introduceLabel;


@end

NS_ASSUME_NONNULL_END
