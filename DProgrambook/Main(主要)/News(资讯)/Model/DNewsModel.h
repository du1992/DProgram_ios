//
//  DNewsModel.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/11.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DNewsModel : DBaseModel



@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *captions;
@property (nonatomic, strong) NSString *article;

@property (nonatomic, strong) NSString *about;


/**cell高度**/
@property (nonatomic)  CGFloat cellHeight;
/**获取高度**/
-(void)calculateHeight;

@end

NS_ASSUME_NONNULL_END
