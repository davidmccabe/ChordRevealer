//
//  CRPianoView.h
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRNote.h"

@interface CRPianoView : UIView
- (void)beginHighlightingNote:(CRNote *)note;
- (void)reset;
- (void)setChordFundamental:(CRNote *)note;
@end
