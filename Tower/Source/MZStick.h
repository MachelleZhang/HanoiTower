//
//  MZStick.h
//  Tower
//
//  Created by Zhangle on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZBlock;

@interface MZStick : UIView

//保存该柱子上砖块的数组
@property (nonatomic, strong) NSMutableArray *blockArray;

- (MZBlock *)popBlock;
- (void)pushBlock:(MZBlock *)pushedItem;
- (Boolean)compareBlock:(MZBlock *)pushedItem;
- (void)resetStick;

@end
