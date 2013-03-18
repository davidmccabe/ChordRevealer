//
//  CRViewController.m
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import "CRViewController.h"
#import "CRPianoView.h"

@interface CRViewController ()
@property (readwrite) IBOutlet CRPianoView *pianoView;
@end

@implementation CRViewController

@synthesize pianoView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pianoView beginHighlightingNote:@"F#"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
