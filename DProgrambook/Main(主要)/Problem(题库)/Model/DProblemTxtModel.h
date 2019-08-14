//
//  DProblemTxtModel.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DProblemTxtModel : DBaseModel

/** 问题 */
@property(nonatomic,strong)NSString     *question;
/** 答案 */
@property(nonatomic,strong)NSString     *answer;

/**cell高度**/
@property (nonatomic)  CGFloat cellHeight;

/**获取高度**/
-(void)calculateHeight;

@end

NS_ASSUME_NONNULL_END
