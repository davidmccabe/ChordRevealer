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
@end

@implementation CRKeyView

@synthesize noteLabel;

+ (CRKeyView *)keyViewWithNoteName:(NSString *)noteName
{
    CRKeyView *key = [CRKeyView new];
    if([noteName hasSuffix:@"#"]) {
        key.keyColor = CRKeyColorBlack;
        key.backgroundColor = [UIColor blackColor];
    }
    else {
        key.keyColor = CRKeyColorWhite;
        key.backgroundColor = [UIColor whiteColor];
    }
    key.noteLabel.text = noteName;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
