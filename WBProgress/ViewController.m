//
//  ViewController.m
//  WBProgress
//
//  Created by Zwb on 16/4/5.
//  Copyright © 2016年 zwb. All rights reserved.
//

#import "ViewController.h"
#import "WBProgressView.h"

@interface ViewController ()
@property (nonatomic, strong) WBProgressView *proview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 初始化
    self.proview = [[WBProgressView alloc] initWithFrame:CGRectMake(0, 0, 80, 80) progress:0.8 lineWidth:5.0 topColor:[UIColor redColor] bottomColor:[UIColor greenColor]];
    // 显示
    [self.proview showProgressViewInView:self.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
