//
//  MZGameViewController.m
//  Tower
//
//  Created by Zhangle on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//
//  游戏控制类

#import "MZGameViewController.h"
#import "MZStick.h"
#import "MZBlock.h"

#define screenSize    [[UIScreen mainScreen] bounds].size

@interface MZGameViewController ()

//保存正在被移动的砖块
@property (nonatomic, strong) MZBlock *movedBlock;
//3个柱子
@property (nonatomic, strong) MZStick *stick1;
@property (nonatomic, strong) MZStick *stick2;
@property (nonatomic, strong) MZStick *stick3;
//计步的标签
@property (nonatomic, strong) UILabel *label;
//总等级，砖块的总数
@property (nonatomic) NSInteger totalLevel;
//总共移动的步数，即结果
@property (nonatomic) NSInteger score;

@end

@implementation MZGameViewController

/**
 *  初始化，读取设置的等级
 *
 *  @return 返回self
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        _score = 0;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *level = [userDefaults objectForKey:@"level"];
        if (!level) {
            _totalLevel = 3;
        } else {
            _totalLevel = level.integerValue;
        }
    }
    return self;
}

#pragma mark
#pragma mark View life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForView];
}

/**
 *  视图准备
 */
- (void)prepareForView {
    //初始化背景
    UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"game_bg"]];
    bgImage.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    [self.view addSubview:bgImage];
    [self.view sendSubviewToBack:bgImage];
    
    //初始化柱子的位置
    CGRect rect1 = CGRectMake(screenSize.width/2-220, screenSize.height/2-100, 140, 200);
    CGRect rect2 = CGRectMake(screenSize.width/2-70, screenSize.height/2-100, 140, 200);
    CGRect rect3 = CGRectMake(screenSize.width/2+80, screenSize.height/2-100, 140, 200);
    _stick1 = [[MZStick alloc] initWithFrame:rect1];
    _stick2 = [[MZStick alloc] initWithFrame:rect2];
    _stick3 = [[MZStick alloc] initWithFrame:rect3];
    [self.view addSubview:_stick1];
    [self.view addSubview:_stick2];
    [self.view addSubview:_stick3];
    
    //初始化砖块到第一个柱子
    for (int i=_totalLevel; i>0; i--) {
        MZBlock *b = [[MZBlock alloc] initWithLevel:i inRect:_stick1.frame andTotal:_totalLevel];
        [_stick1 pushBlock:b];
    }
    
    //计步
    _label = [[UILabel alloc] initWithFrame:CGRectMake(45, 15, 80, 30)];
    UIImageView *labelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_selected"]];
    labelImage.frame = CGRectMake(0, 0, 80, 30);
    [_label addSubview:labelImage];
    [_label sendSubviewToBack:labelImage];
    _label.text = [NSString stringWithFormat:@"步数：%ld", _score];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    
    //重置按钮
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    resetButton.frame = CGRectMake(150, 15, 60, 30);
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    [resetButton setTintColor:[UIColor whiteColor]];
    [resetButton setBackgroundImage:[UIImage imageNamed:@"main_btn"] forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(250, 15, 60, 30);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTintColor:[UIColor whiteColor]];
    [backButton setBackgroundImage:[UIImage imageNamed:@"main_btn"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //在三个柱子上添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fristTap)];
    [_stick1 addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondTap)];
    [_stick2 addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdTap)];
    [_stick3 addGestureRecognizer:tap2];
}

/**
 *  返回按钮响应，返回上一个界面
 */
- (void)backToMenu {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  重置按钮响应，清空所有柱子和步数，再根据设置的等级初始化第一个柱子
 */
- (void)reset {
    [_stick1 resetStick];
    [_stick2 resetStick];
    [_stick3 resetStick];
    _movedBlock = nil;
    _score = 0;
    _label.text = [NSString stringWithFormat:@"步数：%ld", _score];
    for (int i=_totalLevel; i>0; i--) {
        MZBlock *b = [[MZBlock alloc] initWithLevel:i inRect:_stick1.frame andTotal:_totalLevel];
        [_stick1 pushBlock:b];
    }
}

/**
 *  第一个柱子点击事件响应
 */
- (void)fristTap{
    [self tapAction:_stick1];
}

/**
 *  第二个柱子点击事件响应
 */
- (void)secondTap {
    [self tapAction:_stick2];
}

/**
 *  第三个柱子点击事件响应
 */
- (void)thirdTap {
    [self tapAction:_stick3];
}

/**
 *  柱子点击事件处理，先判断是否有移动的砖块，再判断砖块的大小，再添加砖块，更新步数
 *
 *  @param currentStick 当前点击的柱子
 */
- (void)tapAction:(MZStick *)currentStick {
    if (!_movedBlock) {
        _movedBlock = [currentStick popBlock];
        if (_movedBlock) {
            [_movedBlock popLocation:currentStick.frame];
            [currentStick addSubview:_movedBlock];
        }
    } else {
        if ([currentStick compareBlock:_movedBlock]) {
            if (![_movedBlock.father isEqual:currentStick]) {
                _score ++;
            }
            [_movedBlock relocation:currentStick.frame level:currentStick.blockArray.count];
            [currentStick pushBlock:_movedBlock];
            _movedBlock = nil;
            _label.text = [NSString stringWithFormat:@"步数：%ld", _score];
            [self checkSuccess];
        }
    }
}

/**
 *  判断是否游戏结束，判断标志是看所有的砖块是否都在第三个柱子上
 *  结束过后，弹出提示框，保存结果，返回主界面
 */
- (void)checkSuccess {
    if (_stick3.blockArray.count == _totalLevel) {
        NSString *str = [NSString stringWithFormat:@"游戏胜利，共用%ld步！", _score];
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"恭喜" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [successAlert show];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *level = [userDefaults objectForKey:@"level"];
        NSString *rankLevel = [NSString stringWithFormat:@"rank%@", level];
        NSString *lastScore = [userDefaults objectForKey:rankLevel];
        if (lastScore) {
            if (lastScore.integerValue > _score) {
                [userDefaults setObject:[NSString stringWithFormat:@"%ld", _score] forKey:rankLevel];
            }
        } else {
            [userDefaults setObject:[NSString stringWithFormat:@"%ld", _score] forKey:rankLevel];
        }
        [userDefaults synchronize];
    }
}

/**
 *  弹出框的代理，点击确定后返回主界面
 */
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  支持的屏幕方向，仅支持横屏
 *
 *  @return 支持的屏幕方向，仅支持横屏
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
