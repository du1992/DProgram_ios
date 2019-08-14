//
//  DPostModel.h
//  Dprogramming
//
//  Created by DUCHENGWEN on 2017/12/18.
//  Copyright © 2017年 kevindcw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPostModel : DBaseModel

//内容
@property (nonatomic, strong) NSString *content;
//作者
@property (nonatomic, strong) NSString *nickName;
//作者ID
@property (nonatomic, strong) NSString *authorID;
//时间
@property (nonatomic, strong) NSString *dateTime;
//头像
@property (nonatomic, strong) NSString *userLogo;
//是否匿名
@property (nonatomic, strong) NSString *isAnonymous;
/**
 *	 BmobObject对象的id
 */
@property(nonatomic,copy)NSString *objectId;

/**cell高度**/
@property (nonatomic)  CGFloat cellHeight;
/**获取高度**/
-(void)calculateHeight;

@end
