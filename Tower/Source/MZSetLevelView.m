//
//  MZSetLevelView.m
//  Tower
//
//  Created by Zhangle on 15/10/20.
//  Copyright © 2015年 Machelle. All rights reserved.
//
//  设置视图类

#import "MZSetLevelView.h"

@interface MZSetLevelView ()

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation MZSetLevelView

/**
 *  初始化
 *
 *  @return self
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"MZSetLevelView" owner:self options:nil];
        self = viewArray[0];
        
        //读取设置的等级，为空则默认使用 level 3
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *level = [userDefaults objectForKey:@"level"];
        if (!level) {
            _level3.selected = YES;
            _selectedButton = _level3;
            [userDefaults setObject:@"3" forKey:@"level"];
        } else {
            switch (level.integerValue) {
                case 3:
                    _level3.selected = YES;
                    _selectedButton = _level3;
                    break;
                case 4:
                    _level4.selected = YES;
                    _selectedButton = _level4;
                    break;
                case 5:
                    _level5.selected = YES;
                    _selectedButton = _level5;
                    break;
                case 6:
                    _level6.selected = YES;
                    _selectedButton = _level6;
                    break;
                case 7:
                    _level7.selected = YES;
                    _selectedButton = _level7;
                    break;   
                default:
                    break;
            }
        }
        
        //关闭按钮的背景，添加事件
        [_closeSetView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_closeSetView setBackgroundImage:[UIImage imageNamed:@"main_btn"] forState:UIControlStateNormal];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        
        //各等级的事件添加
        [_level3 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
        [_level4 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
        [_level5 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
        [_level6 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
        [_level7 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
        
        //各等级背景图片
        [_level3 setBackgroundImage:[UIImage imageNamed:@"set_normal"] forState:UIControlStateNormal];
        [_level3 setBackgroundImage:[UIImage imageNamed:@"set_selected"] forState:UIControlStateSelected];
        [_level4 setBackgroundImage:[UIImage imageNamed:@"set_normal"] forState:UIControlStateNormal];
        [_level4 setBackgroundImage:[UIImage imageNamed:@"set_selected"] forState:UIControlStateSelected];
        [_level5 setBackgroundImage:[UIImage imageNamed:@"set_normal"] forState:UIControlStateNormal];
        [_level5 setBackgroundImage:[UIImage imageNamed:@"set_selected"] forState:UIControlStateSelected];
        [_level6 setBackgroundImage:[UIImage imageNamed:@"set_normal"] forState:UIControlStateNormal];
        [_level6 setBackgroundImage:[UIImage imageNamed:@"set_selected"] forState:UIControlStateSelected];
        [_level7 setBackgroundImage:[UIImage imageNamed:@"set_normal"] forState:UIControlStateNormal];
        [_level7 setBackgroundImage:[UIImage imageNamed:@"set_selected"] forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  关闭事件响应
 */
- (void)close {
    [self removeFromSuperview];
}

/**
 *  等级切换事件响应
 *
 *  @param sender 点击的按钮
 */
- (void)levelChanged:(UIButton *)sender {
    if (![sender isEqual:_selectedButton]) {
        _selectedButton.selected = NO;
        sender.selected = YES;
        _selectedButton = sender;
        NSString *level = [NSString stringWithFormat:@"%ld", sender.tag];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:level forKey:@"level"];
        [userDefaults synchronize];
    }
}

@end
