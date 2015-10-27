//
//  MZStick.m
//  Tower
//
//  Created by Zhangle on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//
//  柱子类

#import "MZStick.h"
#import "MZBlock.h"

@interface MZStick ()



@end

@implementation MZStick

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

/**
 *  柱子的初始化
 *
 *  @param frame 柱子的frame，也是可点击的范围
 *
 *  @return 返回初始化完成的柱子
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _blockArray = [[NSMutableArray alloc] init];
        UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stick_bg"]];
        bgImage.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:bgImage];
        [self sendSubviewToBack:bgImage];
    }
    return self;
}

/**
 *  弹出一个砖块，先判断砖块数组的数量，有才弹出
 *
 *  @return 返回弹出的砖块
 */
- (MZBlock *)popBlock {
    if (_blockArray.count > 0) {
        MZBlock *popedItem = [_blockArray lastObject];
        [popedItem removeFromSuperview];
        [_blockArray removeLastObject];
        return popedItem;
    } else {
        return nil;
    }
}


/**
 *  砖块比较，满足小的放在大的砖块上这个逻辑
 *
 *  @param pushedItem 欲要放到该柱子上的砖块
 *
 *  @return 如果可放入，就返回true，否则false
 */
- (Boolean)compareBlock:(MZBlock *)pushedItem {
    if (_blockArray.count) {
        MZBlock *b = [_blockArray lastObject];
        if (pushedItem.level < b.level) {
            return true;
        } else {
            return false;
        }
    } else {
        return true;
    }
}

/**
 *  放砖块到柱子上
 *
 *  @param pushedItem 添加的砖块
 */
- (void)pushBlock:(MZBlock *)pushedItem {
    [_blockArray addObject:pushedItem];
    pushedItem.father = self;
    [self addSubview:pushedItem];
}

/**
 *  清空柱子时使用
 */
- (void)resetStick {
    while (_blockArray.count > 0) {
        MZBlock *b = [_blockArray lastObject];
        [b removeFromSuperview];
        [_blockArray removeLastObject];
    }
}

@end
