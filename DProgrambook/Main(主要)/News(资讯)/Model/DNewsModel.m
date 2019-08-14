//
//  DNewsModel.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/11.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DNewsModel.h"

@implementation DNewsModel
/**数据处理**/
-(void)modelDealWith:(BmobObject *)obj{
    
    self.title             = [obj objectForKey:@"title"];
    self.captions          = [obj objectForKey:@"captions"];
    self.article            = [obj objectForKey:@"article"];
    self.about              = [obj objectForKey:@"about"];
  
}

/**获取高度**/
-(void)calculateHeight{
    //文字高度
    
    
    
    CGFloat txtHeight=[self.about boundingRectWithSize:CGSizeMake(kScreenWidth-30,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: AppFont(16)} context:nil].size.height;
    self.cellHeight=txtHeight+240;
    
    
}

@end
