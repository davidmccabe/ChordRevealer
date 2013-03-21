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

@synthesize noteLabel;
@synthesize intervalLabel;
@synthesize note = _note;

+ (CRKeyView *)keyViewWithNote:(CRNote *)theNote
{
    CRKeyView *key = [CRKeyView new];
    key.note = theNote;
    return key;
}

- (CRNote *)note
{
    return _note;
}

- (void)setNote:(CRNote *)theNote
{
    _note = theNote;
    
    self.noteLabel.text = [[theNote name] stringByReplacingOccurrencesOfString:@"#" withString:@"\u266F"];
    
    for(UILabel *label in @[self.noteLabel, self.intervalLabel]) {
        if([theNote isSharp]) {
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor blackColor];
        }
    }
    
    [self setBackgroundColorFromNote];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureWasRecognized:)];
        [self addGestureRecognizer:tapRecognizer];
                
        self.noteLabel = [UILabel new];
        self.intervalLabel = [UILabel new];
        self.intervalLabel.numberOfLines = 2;
        for(UILabel *label in @[self.noteLabel, self.intervalLabel]) {
            label.font = [UIFont systemFontOfSize:10];
            [self addSubview:label];
            label.translatesAutoresizingMaskIntoConstraints = NO;
        }
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints
{
    NSArray *constraints = @[@"V:[intervalLabel]-4-[noteLabel]-4-|",
                             @"H:|-4-[noteLabel]",
                             @"H:|-4-[intervalLabel]"];
    
    for( NSString *constraint in constraints) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:constraint options:0 metrics:nil views:NSDictionaryOfVariableBindings(noteLabel, intervalLabel)]];
    }
    [super updateConstraints];
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

- (void)showIntervalWithFundamental:(CRNote *)fundamental
{
    NSArray *names = [self.note namesOfIntervalWithFundamental:fundamental];
    self.intervalLabel.text = [names componentsJoinedByString:@"\n"];
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
