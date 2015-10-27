//
//  MZStick.h
//  Tower
//
//  Created by boco on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZBlock;

@interface MZStick : UIView

@property (nonatomic, strong) NSMutableArray *blockArray;

- (MZBlock *)popBlock;
- (void)pushBlock:(MZBlock *)pushedItem;
- (Boolean)compareBlock:(MZBlock *)pushedItem;
- (void)resetStick;

@end
