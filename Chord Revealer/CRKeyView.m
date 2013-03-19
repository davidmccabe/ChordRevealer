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

@synthesize noteLabel;

+ (UIColor *)colorForKeyColor:(CRKeyColor)theKeyColor
{
    if (theKeyColor == CRKeyColorBlack)
        return [UIColor blackColor];
    else
        return [UIColor whiteColor];
}

+ (CRKeyView *)keyViewWithNoteName:(NSString *)noteName
{
    CRKeyView *key = [CRKeyView new];
    if([noteName hasSuffix:@"#"]) {
        key.keyColor = CRKeyColorBlack;
    } else {
        key.keyColor = CRKeyColorWhite;
    }
    
    key.backgroundColor = [CRKeyView colorForKeyColor:key.keyColor];
    
    key.noteLabel.text = [noteName stringByReplacingOccurrencesOfString:@"#" withString:@"\u266F"];
    
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
    
    if(self.keyColor == CRKeyColorBlack) {
        self.noteLabel.textColor = [UIColor whiteColor];
        self.noteLabel.backgroundColor = [UIColor blackColor];
    }
}

- (void)beginHighlighting
{
    self.backgroundColor = [UIColor redColor];
}

- (void)stopHighlighting
{
    self.backgroundColor = [CRKeyView colorForKeyColor:self.keyColor];
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
