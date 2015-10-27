//
//  MZBlock.h
//  Tower
//
//  Created by Zhangle on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MZStick;

@interface MZBlock : UIView

@property (nonatomic, readonly) NSInteger level;
@property (nonatomic, weak) MZStick *father;

- (instancetype)initWithLevel:(NSInteger)level inRect:(CGRect)fatherRect andTotal:(NSInteger)totalLevel;
- (MZBlock *)relocation:(CGRect)newRect level:(NSInteger)level;
- (MZBlock *)popLocation:(CGRect)newRect;

@end
