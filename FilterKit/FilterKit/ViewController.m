//
//  ViewController.m
//  FilterKit
//
//  Created by 张雨露 on 2017/3/21.
//  Copyright © 2017年 张雨露. All rights reserved.
//

#import "ViewController.h"
#import "YLBoxView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    YLBoxView *view = [[YLBoxView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40) andTitles:@[@"第一第的的一的", @"第二的的一的", @"第三", @"第四"]];
    [self.view addSubview:view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
