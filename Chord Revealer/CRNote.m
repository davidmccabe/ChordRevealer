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

- (NSArray *)namesOfIntervalWithRoot:(CRNote *)root
{
    NSArray *names = @[
        @[@"P1", @"d2"],
        @[@"m2", @"A1"],
        @[@"M2", @"d3"],
        @[@"m3", @"A2"],
        @[@"M3", @"d4"],
        @[@"P4", @"A3"],
        @[@"d5", @"A4"],
        @[@"P5", @"d6"],
        @[@"m6", @"A5"],
        @[@"M6", @"d7"],
        @[@"m7", @"A6"],
        @[@"M7", @"d8"]];
    
    int d = (self.number - root.number) % 12;
    if (d < 0) d += 12;
    
    return names[d];
}

@end
