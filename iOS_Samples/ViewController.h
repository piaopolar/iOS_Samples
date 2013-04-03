//
//  ViewController.h
//  iOS_Samples
//
//  Created by nd nd on 13-4-2.
//  Copyright (c) 2013年 Banana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, retain) IBOutlet UILabel *label;
-(IBAction)click:(id)sender;
-(IBAction)clickWebPage;
-(IBAction)clickMail;
@end
