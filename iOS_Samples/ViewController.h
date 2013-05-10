//
//  ViewController.h
//  iOS_Samples
//
//  Created by nd nd on 13-4-2.
//  Copyright (c) 2013年 Banana. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController
{
@public
    MPMoviePlayerViewController *moviePlayerController;
}

@property (nonatomic, retain) IBOutlet UILabel *label;
-(IBAction)click:(id)sender;
-(IBAction)clickWebPage;
-(IBAction)clickMail;
-(IBAction)clickVideo;
@end

@interface ViewController(MovieControllerInternal)
-(void)playMovie:(NSString*)moviePath;
-(void)moviePlaybackComplete:(NSNotification *)notification;
@end

