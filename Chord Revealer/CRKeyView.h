//
//  CRKeyView.h
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CRKeyColorWhite,
    CRKeyColorBlack
} CRKeyColor;

@interface CRKeyView : UIView
+ (CRKeyView *)keyViewWithNoteName:(NSString *)noteName;
@property (assign) CRKeyColor keyColor;
- (void)beginHighlighting;
@end
