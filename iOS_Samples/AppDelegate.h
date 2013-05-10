//
//  AppDelegate.h
//  iOS_Samples
//
//  Created by nd nd on 13-4-2.
//  Copyright (c) 2013年 Banana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@class ViewController;

@interface LandscapeMPMoviePlayerViewController : MPMoviePlayerViewController

@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
@public
    LandscapeMPMoviePlayerViewController *moviePlayerController;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end

@interface AppDelegate(MovieControllerInternal)
-(void)moviePlaybackComplete:(NSNotification *)notification;
@end
