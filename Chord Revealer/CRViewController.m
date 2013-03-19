//
//  CRViewController.m
//  Chord Revealer
//
//  Created by David McCabe on 3/18/13.
//  Copyright (c) 2013 David McCabe. All rights reserved.
//

#import "CRViewController.h"
#import "CRPianoView.h"
#import "PdAudioController.h"
#import "PdBase.h"

@interface CRViewController ()
@property (readwrite) IBOutlet CRPianoView *pianoView;
@property (readwrite) PdAudioController *audioController;
@end

@implementation CRViewController

@synthesize pianoView;
@synthesize audioController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pianoView beginHighlightingNote:@"F#"];
    
    self.audioController = [[PdAudioController alloc] init];
	[self.audioController configurePlaybackWithSampleRate:44100 numberChannels:2 inputEnabled:YES mixingEnabled:NO];
	[PdBase openFile:@"revealer.pd" path:[[NSBundle mainBundle] resourcePath]];
	[self.audioController setActive:YES];
	[self.audioController print];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
