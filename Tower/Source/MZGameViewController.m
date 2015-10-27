//
//  MZGameViewController.m
//  Tower
//
//  Created by boco on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//

#import "MZGameViewController.h"
#import "MZStick.h"
#import "MZBlock.h"

#define screenSize    [[UIScreen mainScreen] bounds].size

@interface MZGameViewController ()

@property (nonatomic, strong) MZBlock *movedBlock;
@property (nonatomic, strong) MZStick *stick1;
@property (nonatomic, strong) MZStick *stick2;
@property (nonatomic, strong) MZStick *stick3;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic) NSInteger totalLevel;
@property (nonatomic) NSInteger score;

@end

@implementation MZGameViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect1 = CGRectMake(screenSize.width/2-220, screenSize.height/2-100, 140, 200);
    CGRect rect2 = CGRectMake(screenSize.width/2-70, screenSize.height/2-100, 140, 200);
    CGRect rect3 = CGRectMake(screenSize.width/2+80, screenSize.height/2-100, 140, 200);
    _stick1 = [[MZStick alloc] initWithFrame:rect1];
    _stick2 = [[MZStick alloc] initWithFrame:rect2];
    _stick3 = [[MZStick alloc] initWithFrame:rect3];
    
    [self.view addSubview:_stick1];
    [self.view addSubview:_stick2];
    [self.view addSubview:_stick3];
    
    for (int i=_totalLevel; i>0; i--) {
        MZBlock *b = [[MZBlock alloc] initWithLevel:i inRect:_stick1.frame andTotal:_totalLevel];
        [_stick1 pushBlock:b];
    }
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 100, 10)];
    _label.text = [NSString stringWithFormat:@"步数：%ld", _score];
    [self.view addSubview:_label];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    resetButton.frame = CGRectMake(150, 50, 100, 10);
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(250, 50, 100, 10);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fristTap)];
    [_stick1 addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondTap)];
    [_stick2 addGestureRecognizer:tap1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdTap)];
    [_stick3 addGestureRecognizer:tap2];
}

- (void)backToMenu {
    [self dismissViewControllerAnimated:YES completion:nil];
}

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

- (void)fristTap{
    [self tapAction:_stick1];
}

- (void)secondTap {
    [self tapAction:_stick2];
}

- (void)thirdTap {
    [self tapAction:_stick3];
}

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

- (void)checkSuccess {
    if (_stick3.blockArray.count == _totalLevel) {
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"恭喜" message:@"游戏胜利" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//支持的屏幕方向，仅支持横屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
