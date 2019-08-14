//
//  DBaseModel.h
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/10.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBaseModel : NSObject
//主键ID
@property(nonatomic,assign)NSInteger primaryID;

/**数据处理**/
-(void)modelDealWith:(BmobObject *)obj;


@end

NS_ASSUME_NONNULL_END
