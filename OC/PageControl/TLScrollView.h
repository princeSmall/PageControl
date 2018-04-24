//
//  TLScrollView.h
//  PageControl
//
//  Created by 李敏 on 2018/4/9.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLScrollView : UIView<UIScrollViewDelegate>{
    NSInteger _count;
    NSInteger _page;
    BOOL  isDirection;
}

- (void)setImageCount:(NSUInteger)count;
- (void)startNSTimer;
- (void)endNSTimer;

@end
