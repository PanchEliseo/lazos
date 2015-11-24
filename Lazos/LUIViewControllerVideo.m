//
//  LUIViewControllerVideo.m
//  Lazos
//
//  Created by Programacion on 9/15/15.
//  Copyright (c) 2015 sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUIViewControllerVideo.h"
#import "AppDelegate.h"
#import "LandscapeViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface LUIViewControllerVideo()
{
    MPMoviePlayerViewController *_play;
}

@end

@implementation LUIViewControllerVideo

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Fundación Lazos"];
    [self playMovie];
    
}

-(void)playMovie
{
    
    NSURL *url = [NSURL URLWithString:self.urVideo];
    _play = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(moviePlayBackDidFinish:)
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:nil];
    
    [self presentMoviePlayerViewControllerAnimated:_play];
    
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    
    MPMoviePlayerController *moviePlayer = [notification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:moviePlayer];
    
    if ([moviePlayer
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [moviePlayer.view removeFromSuperview];
    }
    //[moviePlayer release];
}

@end