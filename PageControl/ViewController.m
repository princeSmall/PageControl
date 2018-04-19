//
//  ViewController.m
//  PageControl
//
//  Created by 李敏 on 2018/4/9.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "ViewController.h"
#import "TLScrollView.h"
@interface ViewController ()<UIScrollViewDelegate>{
    NSInteger count;
}
@property (nonatomic,strong) TLScrollView * tlView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    count = 5;
    // Do any additional setup after loading the view, typically from a nib.
}
- (TLScrollView *)tlView{
    if (_tlView == nil) {
        _tlView = [[TLScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        [_tlView setImageCount:count];
    }
    return _tlView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view addSubview:self.tlView];
    [self.tlView startNSTimer];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tlView endNSTimer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
