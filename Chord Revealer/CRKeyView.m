//
//  CRKeyView.m
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import "CRKeyView.h"

@implementation CRKeyView

+ (CRKeyView *)whiteKey
{
    CRKeyView *key = [[CRKeyView alloc] initWithFrame:CGRectZero];
    key.keyColor = CRKeyColorWhite;
    key.backgroundColor = [UIColor grayColor];
    return key;
}

+ (CRKeyView *)blackKey
{
    CRKeyView *key = [[CRKeyView alloc] initWithFrame:CGRectZero];
    key.keyColor = CRKeyColorBlack;
    key.backgroundColor = [UIColor blackColor];
    return key;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
