//
//  DPropsMode.h
//  GetOn
//
//  Created by DUCHENGWEN on 2017/6/2.
//  Copyright © 2017年 Tonchema. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBaseModel.h"


@interface DPropsModel : DBaseModel



/* 道具 */

@property (nonatomic, copy)   NSString  *idString;     //道具id
@property (nonatomic, copy)   NSString  *giftName;     //名字
@property (nonatomic, copy)   NSString  *needCarCoin;  //价值
@property (nonatomic, copy)   NSString  *texiaoPic;    //图标
@property (nonatomic, copy)   NSString  *needPic;      //特效图片
@property (nonatomic, copy)   NSString  *dribble;      //是否连击


/* 用户 */
@property (nonatomic, copy)   NSString  *msg;
@property (nonatomic, copy)   NSString  *nickname;
@property (nonatomic, copy)   NSString  *accountId;
@property (nonatomic, copy)   NSString  *faceUrl;
@property (nonatomic, copy)   NSDate    *time;
//@property (nonatomic, assign) CGFloat   height;

@property (nonatomic, copy)   NSString  *sendId;       //送给谁

@property (nonatomic, copy)   NSString  *sendint;      //连击数

@property (nonatomic) BOOL    selfs;                   //是否自己的
@property (nonatomic) BOOL    iscustom;



-(NSInteger )messageType;       //消息类型
-(NSString *)propId;            //礼物id
-(NSString *)propCount;         //礼物个数
-(NSString *)propName;          //礼物名称
-(NSString *)propPrice;          //礼物价格
-(NSString *)cameraId;           //礼物是送给那个的;
-(NSString *)propSoleMark;      //礼物唯一标示
-(NSString *)getMessageLevel;   //获取消息等级
-(NSString *)getMessageUserName;    //获取用户的昵称

//初始化直播属性
-(void)liveModelAttribute:(NSArray*)array;

//初始化聊天 礼物 ID ---名字-----价值-----图片-----连击数----送礼物的ID----名称----头像
-(void)messageModelAttribute:(NSArray*)array;



-(void)setValue:(id)value forUndefinedKey:(NSString *)key;


//礼物图片
-(NSString *)getPropImageName;


@end
