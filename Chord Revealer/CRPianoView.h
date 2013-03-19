//
//  CRPianoView.h
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRPianoView : UIView
- (void)beginHighlightingNote:(NSString *)noteName;
- (void)reset;
@end
