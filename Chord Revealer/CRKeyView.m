//
//  CRKeyView.m
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import "CRKeyView.h"

@interface CRKeyView ()
@property (readwrite) UILabel *noteLabel;
@property (readwrite) UILabel *intervalLabel;
@end

@implementation CRKeyView

@synthesize note;
@synthesize noteLabel;

+ (CRKeyView *)keyViewWithNote:(CRNote *)theNote
{
    CRKeyView *key = [CRKeyView new];
    key.note = theNote;
    [key setBackgroundColorFromNote];
    key.noteLabel.text = [[theNote name] stringByReplacingOccurrencesOfString:@"#" withString:@"\u266F"];
    return key;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.noteLabel = [UILabel new];
        self.intervalLabel = [UILabel new];
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureWasRecognized:)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)layoutSubviews
{
    for(UILabel *label in @[self.noteLabel, self.intervalLabel]) {
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
        if([self.note isSharp]) {
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor blackColor];
        }
    }
    
    CGFloat padding = 4;
    CGFloat labelHeight = self.noteLabel.intrinsicContentSize.height;
    self.noteLabel.frame = CGRectMake(padding, self.frame.size.height - labelHeight - padding,
                                      self.frame.size.width - padding, labelHeight);
    self.intervalLabel.frame = CGRectMake(
        padding, self.frame.size.height - labelHeight*2 - padding*2,
        self.frame.size.width - padding, labelHeight);
}

- (void)setBackgroundColorFromNote
{
    if ([self.note isSharp]) {
        self.backgroundColor = [UIColor blackColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)beginHighlighting
{
    self.backgroundColor = [UIColor redColor];
}

- (void)stopHighlighting
{
    [self setBackgroundColorFromNote];
}

- (void)tapGestureWasRecognized:(UIGestureRecognizer *)recognizer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noteWasTapped" object:self.note];
}

- (void)showIntervalWithFundamental:(CRNote *)note
{
    self.intervalLabel.text = @"1";
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
