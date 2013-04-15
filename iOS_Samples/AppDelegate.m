//
//  AppDelegate.m
//  iOS_Samples
//
//  Created by nd nd on 13-4-2.
//  Copyright (c) 2013年 Banana. All rights reserved.
//

#import "AppDelegate.h"
#import "GoogleConversionPing.h"
#import "NSString+SBJSON.h"

#import "ViewController.h"

@implementation AppDelegate

static NSString* trackViewURL;

-(void)onCheckVersion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
		NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
		NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];

		NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", [infoDic objectForKey:@"appid" ]];
		NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:url]];
        [request setHTTPMethod:@"POST"];

        NSHTTPURLResponse *urlResponse = nil;
        NSError *error = nil;
        NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
        NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [results JSONValue];
        NSArray *infoArray = [dic objectForKey:@"results"];
		
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([infoArray count]) {
                NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
                NSString *lastVersion = [releaseInfo objectForKey:@"version"];
                
                if (![lastVersion isEqualToString:currentVersion]) {
                    trackViewURL = [[NSString alloc] initWithString: [releaseInfo objectForKey:@"trackViewUrl"]];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Notice" message:@"there is a new version, go to update?" delegate:self cancelButtonTitle:@"close" otherButtonTitles:@"update", nil];
					[alert show];
                }
            }
        });
    });
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1 && trackViewURL) {
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString:trackViewURL]];
		trackViewURL = nil;
    }
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"MyAlertView"
														message:@"Local notification was received, app is in the foreground"
													   delegate:self cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
    [alertView show];
}

- (void) AddLocalNotifications
{	
	UILocalNotification *localNotif = [[UILocalNotification alloc] init];
	if (localNotif == nil) return;
	NSDate *fireTime = [[NSDate date] addTimeInterval:10]; // adds 10 secs
	localNotif.fireDate = fireTime;
	localNotif.alertBody = @"Local notification was received, app is in the background!";
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
	[self onCheckVersion];
	[self AddLocalNotifications];
	[GoogleConversionPing pingWithConversionId:@"0123456789" label:@"abCDEFG12hIJk3Lm4nO" value:@"0.99" isRepeatable:NO];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
