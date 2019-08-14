//
//  DPropsMode.m
//  GetOn
//
//  Created by DUCHENGWEN on 2017/6/2.
//  Copyright © 2017年 Tonchema. All rights reserved.
//

#import "DPropsMode.h"

@implementation DPropsModel


+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"idString":@"id"
             };
}

-(NSString *)getPropImageName{
    switch ([_idString integerValue]) {
        case 1:
            return @"福字";
            break;
        case 2:
            return @"情人鲜花";
            break;
            
        case 3:
            return @"奖杯";
            break;
            
        case 4:
            return @"糖果";
            break;
            
        case 5:
            return @"带你飞";
            break;
            
        case 6:
            return @"大跑车";
            break;
            
        case 7:
            return @"机智少年";
            break;
            
        case 8:
            return @"二踢脚";
            break;
            
            
        case 9:
            return @"balloon";
            break;
            
        case 10:
            return @"大灰机";
            break;
            
        case 11:
            return @"三生三世礼物";
            break;
        
        case 12:
            return @"飞机";
            break;
            
            
            
            
            
    }
    return @"";
    
}

-(NSInteger )messageType{
    
//    NSArray* array = self.messageContentArray;
//    int cmd = [array[0] intValue];
    
//    if (cmd == MSG_CMD_DELIVER) {
//        
//        return MSG_CMD_DELIVER;
//        
//    }else if (cmd == MSG_CMD_ADJUNCTION){
//        
//        return MSG_CMD_ADJUNCTION;
//        
//    }else if (cmd == MSG_CMD_LEAVE){
//        
//        return MSG_CMD_LEAVE;
//        
//    }else if (cmd == YES_I_LEAVE){
//        
//        return YES_I_LEAVE;
//    }else if (cmd == SystemRemind){
//        return SystemRemind;
//    }
    return  20;
    
}


//初始化直播属性
-(void)liveModelAttribute:(NSArray*)array{
//    nickname,userLogo,propsmodel.idString,propsmodel.propName
    self.nickname    =array[1];
    self.faceUrl     =array[2];
    self.idString    =array[3];
    self.giftName    =array[4];
    
}

//-(NSString *)propId{
//    if ([self.messageContentArray count] < 2) {
//        return nil;
//    }
//    
//    return self.messageContentArray[1];
//}
//
//-(NSString *)propCount{
//    NSString *count = @"1";
//    if ([self.messageContentArray count] < 5) {
//        return count = @"1";
//    }else{
//        count = self.messageContentArray[4];
//    }
//    
//    if ([count integerValue] == 0) {
//        count = @"1";
//    }
//    return count;
//}
//-(NSString *)propPrice{
//    if ([self.messageContentArray count] < 4) {
//        return nil;
//    }
//    return self.messageContentArray[3];
//    
//}
//
//-(NSString *)cameraId{
//    NSArray* array = self.messageContentArray;
//    if ([array count] < 6) {
//        return nil;
//    }
//    return array[5];
//}

//-(NSString *)propName{

//    if ([self.messageContentArray count] > 3) {
//        return self.messageContentArray[2];
//    }
//    return @"新礼物";

//}

//礼物唯一标示
-(NSString *)propSoleMark{
    NSString *SoleMark = [NSString stringWithFormat:@"%@&%@",self.idString,self.sendId];
    return SoleMark;
}

//-(NSArray *)messageContentArray{
//    if (_messageContentArray) {
//        return _messageContentArray;
//    }else{
//        self.messageContentArray = [self.msg componentsSeparatedByString:MSG_SEPERATOR];
//        return _messageContentArray;
//    }
//    
//}

//获取消息等级
-(NSString *)getMessageLevel{
    return nil;
    //    NSArray *array = [self.nickname componentsSeparatedByString:@"\\u"];
    //    if ([array count] > 1) {
    //        if ([[array lastObject] integerValue] == 0) {
    //            return nil;
    //        }
    //        return  [array lastObject];
    //    }else{
    //        return nil;
    //    }
}





//获取用户的昵称
-(NSString *)getMessageUserName{
    NSArray *array = [self.nickname componentsSeparatedByString:@"\\u"];
    if ([array count] > 0) {
        return [array firstObject];
    }else{
        return @"";
    }
    
}






@end
