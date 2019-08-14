//
//  DBookModel.h
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/1.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAGridItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DBookModel : BAGridItemModel

/**作者**/
@property (nonatomic, strong) NSString *author;
/**简介**/
@property (nonatomic, strong) NSString *introduction;
/**ID**/
@property (nonatomic, strong) NSString *bookID;
/**章节**/
@property (nonatomic, strong) NSArray *chapterArray;

/**是否是本地**/
@property (nonatomic) BOOL isLocal;

@end

NS_ASSUME_NONNULL_END
