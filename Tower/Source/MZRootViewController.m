//
//  MZRootViewController.m
//  Tower
//
//  Created by boco on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//

#import "MZRootViewController.h"
#import "MZGameViewController.h"
#import "MZStick.h"
#import "MZSetLevelView.h"
#import "MZRankView.h"

#define screenSize    [[UIScreen mainScreen] bounds].size

@interface MZRootViewController ()

@property (nonatomic, strong) UIViewController *popController;

@end

@implementation MZRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeSystem];
    startButton.frame = CGRectMake(screenSize.width/2-50,screenSize.height-100, 100, 10);
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeSystem];
    setButton.frame = CGRectMake(screenSize.width/2-150,screenSize.height-100, 100, 10);
    [setButton setTitle:@"设置" forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setLevel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setButton];
    
    UIButton *rankButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rankButton.frame = CGRectMake(screenSize.width/2+50,screenSize.height-100, 100, 10);
    [rankButton setTitle:@"排行榜" forState:UIControlStateNormal];
    [rankButton addTarget:self action:@selector(rankList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rankButton];
}

- (void)start {
    MZGameViewController *gvc = [[MZGameViewController alloc] init];
    [self presentViewController:gvc animated:YES completion:nil];
}

- (void)setLevel {
    MZSetLevelView *setView = [[MZSetLevelView alloc] init];
    [self.view addSubview:setView];
}

- (void)rankList {
    MZRankView *rankView = [[MZRankView alloc] init];
    [self.view addSubview:rankView];
}

@end
