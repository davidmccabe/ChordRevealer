//
//  CRNote.m
//  Chord Revealer
//
//  Created by David McCabe on 3/19/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import "CRNote.h"

@implementation CRNote

@synthesize number;

+ (NSArray *)notesFromNumber:(int)startNumber toNumber:(int)endNumber
{
    NSMutableArray *a = [NSMutableArray arrayWithCapacity:endNumber - startNumber];
    for(int noteNumber = startNumber; noteNumber <= endNumber; noteNumber++) {
        [a addObject:[CRNote noteWithNumber:noteNumber]];
    }
    return a;
}

+ (CRNote *)noteWithNumber:(int)theNumber
{
    CRNote *note = [CRNote new];
    note.number = theNumber;
    return note;
}

- (NSString *)name
{
    NSArray *scale = [@"C C# D D# E F F# G G# A A# B" componentsSeparatedByString:@" "];
    return [scale objectAtIndex:(self.number % 12)];
}

- (BOOL)isSharp
{
    return [[self name] hasSuffix:@"#"];
}

@end
