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
    self.backgroundColor = [UIColor grayColor];
    
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
    int numberOfWhiteKeys = 7;
    float x = 0;
    float gap = 1;
    float keyWidth = self.frame.size.width/numberOfWhiteKeys - gap / 2;
    float height = self.frame.size.height;
    for(CRKeyView *key in self.keyViews) {
        if(key.keyColor == CRKeyColorWhite) {
            key.frame = CGRectMake(x, 0, keyWidth, height);
            x += keyWidth + gap;
        } else {
            key.frame = CGRectMake(x - (keyWidth + gap) / 2, 0, keyWidth, (height*2)/3);
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
