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
#import "PdDispatcher.h"
#import <math.h>
#import "CRNote.h"

void fiddle_tilde_setup();

@interface CRViewController ()
@property (readwrite) IBOutlet CRPianoView *pianoView;
@property (readwrite) PdAudioController *audioController;
@property (readwrite) PdDispatcher *dispatcher;
@property (assign) int numberOfNotesSinceReset;
@property (assign) int numberOfStrings;
@end

@implementation CRViewController

@synthesize pianoView;
@synthesize audioController;
@synthesize dispatcher;
@synthesize numberOfNotesSinceReset;
@synthesize numberOfStrings;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.numberOfStrings = 4;
    self.numberOfNotesSinceReset = 0;
    
    self.audioController = [[PdAudioController alloc] init];
	[self.audioController configurePlaybackWithSampleRate:44100 numberChannels:2 inputEnabled:YES mixingEnabled:NO];
    
    self.dispatcher = [[PdDispatcher alloc] init];
    [self.dispatcher addListener:self forSource:@"pitch"];
    [PdBase setDelegate:self.dispatcher];
    fiddle_tilde_setup();

	[PdBase openFile:@"revealer.pd" path:[[NSBundle mainBundle] resourcePath]];
	[self.audioController setActive:YES];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(resetGestureWasRecognized:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
    [self.pianoView addGestureRecognizer:swipeRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noteWasTapped:) name:@"noteWasTapped" object:nil];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)noteWasTapped:(NSNotification *)theNotification
{
    CRNote *note = theNotification.object;
    [self.pianoView setChordFundamental:note];
}

- (void)receiveFloat:(float)pitch fromSource:(NSString *)source {
    numberOfNotesSinceReset++;
    if (numberOfNotesSinceReset > numberOfStrings) {
        [self.pianoView reset];
        numberOfNotesSinceReset = 1;
    }
    [self.pianoView beginHighlightingNote:[CRNote noteWithNumber:round(pitch)]];
}

- (void)resetGestureWasRecognized:(UIGestureRecognizer *)recognizer
{
    numberOfNotesSinceReset = 0;
    [self.pianoView reset];
}




@end
