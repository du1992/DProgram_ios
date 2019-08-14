//
//  DPostModel.m
//  Dprogramming
//
//  Created by DUCHENGWEN on 2017/12/18.
//  Copyright © 2017年 kevindcw. All rights reserved.
//

#import "DPostModel.h"

@implementation DPostModel


-(void)modelDealWith:(BmobObject *)obj{


    self.content    = [obj objectForKey:@"content"];


    self.nickName  = [obj objectForKey:@"nickName"];


    self.authorID  = [obj objectForKey:@"authorID"];



    self.dateTime = [obj objectForKey:@"dateTime"];

    self.userLogo    = [obj objectForKey:@"userLogo"];

 



    self.isAnonymous  = [obj objectForKey:@"isAnonymous"];
    

self.objectId=obj.objectId;
    
}


/**获取高度**/
-(void)calculateHeight{
    //文字高度
    CGFloat txtHeight=[self.content boundingRectWithSize:CGSizeMake(kScreenWidth-24,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: AppFont(14)} context:nil].size.height;
    self.cellHeight=txtHeight+100;
    
    
}
@end
