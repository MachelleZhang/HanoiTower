//
//  MZBlock.m
//  Tower
//
//  Created by boco on 15/10/19.
//  Copyright © 2015年 Machelle. All rights reserved.
//

#import "MZBlock.h"

#define baseWidth   20
#define baseHeight  10
#define offsetHeight 30
#define popHeight 30

@interface MZBlock ()

@end

@implementation MZBlock

- (instancetype)initWithLevel:(NSInteger)level inRect:(CGRect)fatherRect andTotal:(NSInteger)totalLevel{
    self = [super init];
    if (self) {
        _level = level;
        self.frame = CGRectMake(fatherRect.size.width/2.0 - level/2.0 * baseWidth,
                                fatherRect.size.height - offsetHeight - (totalLevel-level) * (baseHeight+2.0),
                                level * baseWidth,
                                baseHeight);
        self.layer.cornerRadius = 3;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (MZBlock *)relocation:(CGRect)newRect level:(NSInteger)level {
    CGRect temp = self.frame;
    temp.origin.x = newRect.size.width/2.0 - _level/2.0 * baseWidth;
    temp.origin.y = newRect.size.height - offsetHeight - level * (baseHeight+2.0);
    self.frame = temp;
    return self;
}

- (MZBlock *)popLocation:(CGRect)newRect {
    CGRect temp = self.frame;
    temp.origin.x = newRect.size.width/2.0 - _level/2.0 * baseWidth;
    temp.origin.y = popHeight;
    self.frame = temp;
    return self;
}

@end
