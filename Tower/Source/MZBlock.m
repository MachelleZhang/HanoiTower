//
//  MZBlock.m
//  Tower
//
//  Created by Zhangle on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//
//  砖块类

#import "MZBlock.h"

//砖块的基本宽度，要乘以等级才是显示的宽度
#define baseWidth   20
//砖块的基本高度
#define baseHeight  10
//离父视图的底部距离
#define offsetHeight 40
//弹出的砖块离父视图顶部的距离
#define popHeight 30

@interface MZBlock ()

@end

@implementation MZBlock

//初始化方法，传入砖块的等级(即大小)，父视图的frame，总的砖块数量
/**
 *  初始化方法，在第一个柱子上添加设置的砖块数目
 *
 *  @param level      当前砖块的等级，即该砖块的大小
 *  @param fatherRect 父视图的frame，初始化时在第一个柱子
 *  @param totalLevel 总的砖块数
 *
 *  @return 返回位置初始化完成的砖块，添加到父视图中
 */
- (instancetype)initWithLevel:(NSInteger)level inRect:(CGRect)fatherRect andTotal:(NSInteger)totalLevel{
    self = [super init];
    if (self) {
        _level = level;
        self.frame = CGRectMake(fatherRect.size.width/2.0 - level/2.0 * baseWidth,
                                fatherRect.size.height - offsetHeight - (totalLevel-level) * (baseHeight),
                                level * baseWidth,
                                baseHeight);
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

/**
 *  砖块压入柱子之前，需要根据柱子上已经存在的砖块数目来重新定位
 *
 *  @param newRect 欲添加到的柱子
 *  @param level   柱子上已经存在的砖块数目
 *
 *  @return 返回定位后的砖块
 */
- (MZBlock *)relocation:(CGRect)newRect level:(NSInteger)level {
    CGRect temp = self.frame;
    temp.origin.x = newRect.size.width/2.0 - _level/2.0 * baseWidth;
    temp.origin.y = newRect.size.height - offsetHeight - level * (baseHeight);
    self.frame = temp;
    return self;
}

/**
 *  要弹出砖块的时候定位，将弹出的砖块的y进行改变
 *
 *  @param newRect 弹出的柱子
 *
 *  @return 返回定位后的砖块
 */
- (MZBlock *)popLocation:(CGRect)newRect {
    CGRect temp = self.frame;
    temp.origin.x = newRect.size.width/2.0 - _level/2.0 * baseWidth;
    temp.origin.y = popHeight;
    self.frame = temp;
    return self;
}

@end
