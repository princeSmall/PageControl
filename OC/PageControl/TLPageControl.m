//
//  TLPageControl.m
//  PageControl
//
//  Created by 李敏 on 2018/4/24.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "TLPageControl.h"

#define dotW 15      // 圆点宽
#define dotH 6       // 圆点高
#define magrin 0     // 圆点间距

@implementation TLPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 1.修改大小，创建一个类，继承UIPageControl，重写layoutSubviews方法，可设置圆点大小
- (void)layoutSubviews
{
    [super layoutSubviews];
    //计算圆点间距
    CGFloat marginX = dotW + magrin;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;
    
    CGFloat   kScreenW = [UIScreen mainScreen].bounds.size.width;
    //设置新frame
    self.frame = CGRectMake(kScreenW/2-(newW + dotW)/2, self.frame.origin.y, newW + dotW, self.frame.size.height);
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView * dot = [self.subviews objectAtIndex:i];
       
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW - 2, dotH)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        }
    }
  
}

@end
