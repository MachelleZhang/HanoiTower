//
//  MZStick.m
//  Tower
//
//  Created by boco on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//

#import "MZStick.h"
#import "MZBlock.h"

@interface MZStick ()



@end

@implementation MZStick

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _blockArray = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

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

- (void)pushBlock:(MZBlock *)pushedItem {
    [_blockArray addObject:pushedItem];
    pushedItem.father = self;
    [self addSubview:pushedItem];
}

- (void)resetStick {
    while (_blockArray.count > 0) {
        MZBlock *b = [_blockArray lastObject];
        [b removeFromSuperview];
        [_blockArray removeLastObject];
    }
}

@end
