//
//  UIView+Frame.m
//  mdbobo
//
//  Created by WangZhen on 2016/11/14.
//  Copyright © 2016年 WangZhen. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)


- (CGFloat)fw_x {
    
    return self.frame.origin.x;
}

- (void)setFw_x:(CGFloat)fw_x {
    
    //取出调用这个方法的view对象的frame
    CGRect frame = self.frame;
    //改变传进来的对应的值
    frame.origin.x = fw_x;
    //把改变后的frame赋给调用这个方法的view对象
    self.frame = frame;
}






- (CGFloat)fw_y {
    
    return self.frame.origin.y;
}

- (void)setFw_y:(CGFloat)fw_y {
    
    CGRect frame = self.frame;
    frame.origin.y = fw_y;
    self.frame = frame;
}





- (CGFloat)fw_width {
    
    return self.frame.size.width;
}

- (void)setFw_width:(CGFloat)fw_width {
    
    CGRect frame = self.frame;
    frame.size.width = fw_width;
    self.frame = frame;
}





- (CGFloat)fw_height {
    
    return self.frame.size.height;
}

- (void)setFw_height:(CGFloat)fw_height {
    
    CGRect frame = self.frame;
    frame.size.height = fw_height;
    self.frame = frame;
}


- (CGFloat)fw_center_x {
    
    return self.center.x;
}
- (void)setFw_center_x:(CGFloat)fw_center_x {
    
    CGPoint center = self.center;
    center.x = fw_center_x;
    self.center = center;
}



- (CGFloat)fw_center_y {
    
    return self.center.y;
}
- (void)setFw_center_y:(CGFloat)fw_center_y {
    
    CGPoint center = self.center;
    center.y = fw_center_y;
    self.center = center;
}

@end
