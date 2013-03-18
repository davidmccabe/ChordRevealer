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
@property (nonatomic, readwrite) NSMutableDictionary *keyViewsByNoteName;
@end

@implementation CRPianoView

@synthesize keyViewsByNoteName;

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
    self.keyViewsByNoteName = [NSMutableDictionary dictionaryWithCapacity:12];
    
    NSString *scale = @"C C# D D# E F F# G G# A A# B";
    for(NSString *note in [scale componentsSeparatedByString:@" "]) {
        CRKeyView *keyView = [CRKeyView keyViewWithNoteName:note];
        [self.keyViewsByNoteName setObject:keyView forKey:note];
        [self.keyViews addObject:keyView];
        [self addSubview:keyView];
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

- (void)beginHighlightingNote:(NSString *)noteName
{
    [[self.keyViewsByNoteName objectForKey:noteName] beginHighlighting];
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
