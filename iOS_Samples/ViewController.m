//
//  ViewController.m
//  iOS_Samples
//
//  Created by nd nd on 13-4-2.
//  Copyright (c) 2013年 Banana. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
@end
