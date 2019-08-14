//
//  DProblemTxtCell.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DProblemTxtCell : DTableViewCell

/** 问题 */
@property(nonatomic,strong)UILabel     *questionLabel;
/** 答案 */
@property(nonatomic,strong)UILabel     *answerLabel;
/** 背景视图 */
@property(nonatomic,strong)UIView      *bgView;

@end

NS_ASSUME_NONNULL_END
