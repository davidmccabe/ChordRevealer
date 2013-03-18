//
//  CRPianoView.m
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import "CRPianoView.h"
#import "CRKeyView.h"

@interface CRPianoView ()
@property (nonatomic, readwrite) NSMutableArray *keyViews;
@end

@implementation CRPianoView

@synthesize keyViews;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.keyViews = [NSMutableArray arrayWithCapacity:12];
    
    NSString *layout = @"wbwbwwbwbwbw";
    for(int i = 0; i < [layout length]; i++) {
        NSString *c = [layout substringWithRange:NSMakeRange(i, 1)];

        CRKeyView *key;
        if([c isEqual:@"w"]) {
            key = [CRKeyView whiteKey];
        } else {
            key = [CRKeyView blackKey];
        }
        [self.keyViews addObject:key];
        [self addSubview:key];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    float x = 0;
    float gap = 5;
    float width = 32;
    float height = 100;
    for(CRKeyView *key in self.keyViews) {
        if(key.keyColor == CRKeyColorWhite) {
            key.center = CGPointMake(x,0);
            key.bounds = CGRectMake(0,0,width,height);
            x += width + gap;
        } else {
            key.center = CGPointMake(x - (width + gap) / 2, -height/3);
            key.bounds = CGRectMake(0,0,width,height);
            [self bringSubviewToFront:key];
        }
    }
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
