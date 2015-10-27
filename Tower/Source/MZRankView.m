//
//  MZRankView.m
//  Tower
//
//  Created by Zhangle on 15/10/21.
//  Copyright © 2015年 Machelle. All rights reserved.
//
//  排行榜视图类

#import "MZRankView.h"

@implementation MZRankView

/**
 *  初始化，读出数据显示即可
 *
 *  @return self
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"MZRankView" owner:self options:nil];
        self = viewArray[0];
        
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.borderWidth = 1;
        
        [_closeRank addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *score3 = [userDefaults objectForKey:@"rank3"];
        NSString *score4 = [userDefaults objectForKey:@"rank4"];
        NSString *score5 = [userDefaults objectForKey:@"rank5"];
        NSString *score6 = [userDefaults objectForKey:@"rank6"];
        NSString *score7 = [userDefaults objectForKey:@"rank7"];
        _score3.text = score3 ? score3: @"空";
        _score4.text = score4 ? score4: @"空";
        _score5.text = score5 ? score5: @"空";
        _score6.text = score6 ? score6: @"空";
        _score7.text = score7 ? score7: @"空";
    }
    return self;
}

/**
 *  关闭事件响应
 */
- (void)close {
    [self removeFromSuperview];
}

@end
