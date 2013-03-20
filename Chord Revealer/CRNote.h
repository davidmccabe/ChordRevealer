//
//  CRNote.h
//  Chord Revealer
//
//  Created by David McCabe on 3/19/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRNote : NSObject

@property (assign) int number;

+ (NSArray *)notesFromNumber:(int)startNumber toNumber:(int)endNumber;
+ (CRNote *)noteWithNumber:(int)theNumber;
- (NSString *)name;
- (BOOL)isSharp;

@end
