//
//  ViewController.m
//  iOS_Samples
//
//  Created by nd nd on 13-4-2.
//  Copyright (c) 2013年 Banana. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController(MovieControllerInternal)
-(void) playMovie :(NSString*)moviePath
{
	NSString* videoPath = moviePath;
	NSURL* videoURL = [NSURL fileURLWithPath:videoPath];
	
	if ([self respondsToSelector:@selector(presentMoviePlayerViewControllerAnimated:)]) {
		// OS > 3.2
        moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
		if (moviePlayerController) {
			moviePlayerController.moviePlayer.view.frame = self.view.bounds;
			moviePlayerController.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
			[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlaybackComplete:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
			[moviePlayerController.moviePlayer play];
			[self.view addSubview:moviePlayerController.view];
		}
	}
}

- (void)moviePlaybackComplete:(NSNotification *)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:MPMoviePlayerPlaybackDidFinishNotification
												  object:moviePlayerController];
	
	[moviePlayerController.view removeFromSuperview];
}
@end


@implementation ViewController
@synthesize label;

- (void)viewDidLoad
{
    [super viewDidLoad];
    label.text = @"apple";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)click:(id)sender
{
    label.text = @"Banana";
}

-(IBAction)clickWebPage
{
	[[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://blog.csdn.net/piao_polar"]]];
}

-(IBAction)clickMail
{
	NSString *url = @"mailto:piao_polar@163.com?cc=piao.polar@gmail.com&subject=My Issue&body=can use blank here";
	NSString *escaped = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
}

-(IBAction)clickVideo
{
	NSString* resourcePath = [[NSBundle mainBundle] resourcePath];
	NSString* videoPath = [resourcePath stringByAppendingPathComponent:@"Launch.m4v"];
	[self playMovie:videoPath];
}
@end
