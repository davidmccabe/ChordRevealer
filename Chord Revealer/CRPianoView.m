//
//  CRPianoView.m
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import "CRPianoView.h"
#import "CRKeyView.h"
#import "MACollectionUtilities.h"

@interface CRPianoView ()
@property (readwrite) NSArray *notes;
@property (readwrite) NSMutableArray *keyViews;
@property (assign) int startingNoteNumber;
@property (assign) int endingNoteNumber;
@end

@implementation CRPianoView

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

    self.startingNoteNumber = 60; // C0.
    self.endingNoteNumber = 80;
    
    self.notes = [CRNote notesFromNumber:self.startingNoteNumber toNumber:self.endingNoteNumber];
    self.keyViews = [NSMutableArray arrayWithCapacity:self.notes.count];
    
    for(CRNote *note in self.notes) {
        CRKeyView *keyView = [CRKeyView keyViewWithNote:note];
        [self.keyViews addObject:keyView];
        [self addSubview:keyView];
    }
}

- (int)numberOfWhiteKeys
{
    return [REJECT(self.notes, [obj isSharp]) count];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    float gap = 1;
    float keyWidth = self.frame.size.width/[self numberOfWhiteKeys] - gap / 2;
    float height = self.frame.size.height;

    float x = 0;
    for(CRKeyView *key in self.keyViews) {
        if(! [key.note isSharp]) {
            key.frame = CGRectMake(x, 0, keyWidth, height);
            x += keyWidth + gap;
        } else {
            key.frame = CGRectMake(x - (keyWidth + gap) / 2, 0, keyWidth, (height*2)/3);
            [self bringSubviewToFront:key];
        }
    }
}

- (void)beginHighlightingNote:(CRNote *)note
{
    int indexForNote = note.number - self.startingNoteNumber;
    if( 0 <= indexForNote && indexForNote < self.keyViews.count ) {
        [[self.keyViews objectAtIndex:indexForNote] beginHighlighting];
    }
}

- (void)reset
{
    for(CRKeyView *key in self.keyViews) {
        [key stopHighlighting];
    }
}

- (void)setChordFundamental:(CRNote *)note
{
    for(CRKeyView *key in self.keyViews) {
        [key showIntervalWithFundamental:note];
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
