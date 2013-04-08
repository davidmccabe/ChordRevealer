//
//  CRKeyView.h
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRNote.h"

@interface CRKeyView : UIView
+ (CRKeyView *)keyViewWithNote:(CRNote *)noteNumber;
@property (readwrite) CRNote *note;
- (void)beginHighlightingAsString:(int)string outOf:(int)numberOfStrings;
- (void)stopHighlighting;
- (void)showIntervalWithRoot:(CRNote *)note;
@end
