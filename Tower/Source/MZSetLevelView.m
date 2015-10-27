//
//  MZSetLevelView.m
//  Tower
//
//  Created by boco on 15/10/20.
//  Copyright © 2015年 Machelle. All rights reserved.
//

#import "MZSetLevelView.h"

@interface MZSetLevelView ()

@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation MZSetLevelView

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"MZSetLevelView" owner:self options:nil];
        self = viewArray[0];
        
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
        [_closeSetView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        [_level3 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
        [_level4 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
        [_level5 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
        [_level6 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
        [_level7 addTarget:self action:@selector(levelChanged:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)close {
    [self removeFromSuperview];
}

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
