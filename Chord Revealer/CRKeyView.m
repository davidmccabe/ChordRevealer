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
@property (readwrite) UIColor *intrinsicBackgroundColor;
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
    key.noteLabel.font = [UIFont systemFontOfSize:10];
    return key;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.noteLabel = [UILabel new];
        [self addSubview:self.noteLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat padding = 4;
    CGFloat labelHeight = self.noteLabel.intrinsicContentSize.height;
    self.noteLabel.frame = CGRectMake(padding, self.frame.size.height - labelHeight - padding,
                                      self.frame.size.width - padding, labelHeight);
    
    if([self.note isSharp]) {
        self.noteLabel.textColor = [UIColor whiteColor];
        self.noteLabel.backgroundColor = [UIColor blackColor];
    }
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
