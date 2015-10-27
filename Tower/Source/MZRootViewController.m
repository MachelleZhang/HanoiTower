//
//  MZRootViewController.m
//  Tower
//
//  Created by Zhangle on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//
//  主界面

#import "MZRootViewController.h"
#import "MZGameViewController.h"
#import "MZStick.h"
#import "MZSetLevelView.h"
#import "MZRankView.h"

//屏幕size
#define screenSize    [[UIScreen mainScreen] bounds].size

@interface MZRootViewController ()

@property (nonatomic, strong) UIViewController *popController;

@end

@implementation MZRootViewController

#pragma mark
#pragma mark View life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForView];
}

/**
 *  视图准备，按钮，背景图片等等
 */
- (void)prepareForView {
    //背景
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_bg"]];
    bgImage.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    [self.view addSubview:bgImage];
    [self.view sendSubviewToBack:bgImage];
    
    //开始按钮
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    startButton.frame = CGRectMake(screenSize.width/2-40,screenSize.height/2+50, 80, 30);
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    startButton.tintColor = [UIColor whiteColor];
    [startButton setBackgroundImage:[UIImage imageNamed:@"main_btn"] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    //设置按钮
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeCustom];
    setButton.frame = CGRectMake(screenSize.width/2-140,screenSize.height/2+50, 80, 30);
    [setButton setTitle:@"设置" forState:UIControlStateNormal];
    setButton.tintColor = [UIColor whiteColor];
    [setButton setBackgroundImage:[UIImage imageNamed:@"main_btn"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setLevel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setButton];
    
    //排行榜按钮
    UIButton *rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rankButton.frame = CGRectMake(screenSize.width/2+60,screenSize.height/2+50, 80, 30);
    [rankButton setTitle:@"排行榜" forState:UIControlStateNormal];
    rankButton.tintColor = [UIColor whiteColor];
    [rankButton setBackgroundImage:[UIImage imageNamed:@"main_btn"] forState:UIControlStateNormal];
    [rankButton addTarget:self action:@selector(rankList) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rankButton];
}

/**
 *  开始按钮响应，弹出 game view
 */
- (void)start {
    MZGameViewController *gvc = [[MZGameViewController alloc] init];
    [self presentViewController:gvc animated:YES completion:nil];
}

/**
 *  设置等级按钮响应，即弹出 set level view
 */
- (void)setLevel {
    MZSetLevelView *setView = [[MZSetLevelView alloc] init];
    setView.frame = CGRectMake(screenSize.width/2-150, screenSize.height/2-100, 300, 200);
    UIImageView *setImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_bg"]];
    setImage.frame = CGRectMake(0, 0, 300, 200);
    [setView addSubview:setImage];
    [setView sendSubviewToBack:setImage];
    [self.view addSubview:setView];
}

/**
 *  排行榜按钮响应，弹出 rank view
 */
- (void)rankList {
    MZRankView *rankView = [[MZRankView alloc] init];
    rankView.frame = CGRectMake(screenSize.width/2-200, screenSize.height/2-140, 400, 280);
    UIImageView *rankImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rank_bg"]];
    rankImage.frame = CGRectMake(0, 0, 400, 280);
    [rankView addSubview:rankImage];
    [rankView sendSubviewToBack:rankImage];
    [self.view addSubview:rankView];
}

@end
