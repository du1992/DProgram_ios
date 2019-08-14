//
//  DBookTxtModel.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/3.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBookTxtModel : DBaseModel

/**标题**/
@property (nonatomic, strong) NSString *title;
/**内容**/
@property (nonatomic, strong) NSString *txt;
/**cell高度**/
@property (nonatomic)  CGFloat cellHeight;
/**获取高度**/
-(void)calculateHeight;
@end

NS_ASSUME_NONNULL_END
