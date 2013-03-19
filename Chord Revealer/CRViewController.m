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

void fiddle_tilde_setup();

@interface CRViewController ()
@property (readwrite) IBOutlet CRPianoView *pianoView;
@property (readwrite) PdAudioController *audioController;
@property (readwrite) PdDispatcher *dispatcher;
@end

@implementation CRViewController

@synthesize pianoView;
@synthesize audioController;
@synthesize dispatcher;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pianoView beginHighlightingNote:@"F#"];
    
    self.audioController = [[PdAudioController alloc] init];
	[self.audioController configurePlaybackWithSampleRate:44100 numberChannels:2 inputEnabled:YES mixingEnabled:NO];
    
    self.dispatcher = [[PdDispatcher alloc] init];
    [self.dispatcher addListener:self forSource:@"pitch"];
    [PdBase setDelegate:self.dispatcher];
    fiddle_tilde_setup();

	[PdBase openFile:@"revealer.pd" path:[[NSBundle mainBundle] resourcePath]];
	[self.audioController setActive:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receiveFloat:(float)value fromSource:(NSString *)source {
    NSLog(@"pitch: %f", value);
}


@end
