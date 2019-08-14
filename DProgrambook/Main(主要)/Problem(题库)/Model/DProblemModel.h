//
//  DProblemModel.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/10.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DProblemModel : DBaseModel

/**id**/
@property (nonatomic, strong) NSString *problemID;
/**标题**/
@property (nonatomic, strong) NSString *title;
/**介绍**/
@property (nonatomic, strong) NSString *introduce;
/**用法**/
@property (nonatomic, strong) NSString *directions;
/**称号**/
@property (nonatomic, strong) NSString *honor;
/**封面**/
@property (nonatomic, strong) NSString *backgroundImg;

@end

NS_ASSUME_NONNULL_END
