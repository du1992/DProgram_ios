//
//  DBookTxtModel.m
//  DProgrambook
//
//  Created by DUCHENGWEN on 2019/8/3.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBookTxtModel.h"

@implementation DBookTxtModel

/**数据处理**/
-(void)modelDealWith:(BmobObject *)obj{
    
    self.title              = [obj objectForKey:@"title"];
    self.txt                = [obj objectForKey:@"txt"];
    
    
}

/**获取高度**/
-(void)calculateHeight{
    //文字高度

    
   
  
    
    CGSize titleSize = [self.title boundingRectWithSize:CGSizeMake(kScreenWidth-30, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[[DBookManager defaultManager] getTitleFontSize]} context:nil].size;
    
 
    
    
    
    NSString*txt =[self.txt stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    self.txt =txt;
    CGFloat txtHeight=[self.txt boundingRectWithSize:CGSizeMake(kScreenWidth-30,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [[DBookManager defaultManager] getTxtFontSize]} context:nil].size.height;
    self.cellHeight=titleSize.height+txtHeight+60;
  
    
}

@end
