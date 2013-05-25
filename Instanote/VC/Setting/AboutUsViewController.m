//
//  AboutUsViewController.m
//  Instanote
//
//  Created by Man Tung on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutUsViewController.h"
#import "UILabel+Extensions.h"

#import <QuartzCore/QuartzCore.h>

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * backButton = [[UIButton alloc] init];
    [backButton setBackgroundColor:[UIColor blackColor]];
    [backButton setTitle:@"x" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(295, 6, 24, 24)];
    [[backButton layer] setCornerRadius:12.f];
    [backButton addTarget:self action:(@selector(backAction)) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel * mylabel = [[UILabel alloc] init];
    [mylabel setBackgroundColor:[UIColor clearColor]];
    [mylabel setText:@"Instanote just like the title, is an instant productivity which can capture your thoughts, ideas, poems and inspirations before gone.We are working on making the app instant and simple to use, and you can add notes with one button touch but no more finger shift."];
    [mylabel setFont:[UIFont systemFontOfSize:28]];
    [mylabel setFrame:CGRectMake(5, 5, 310, 440)];
    [mylabel sizeToFitFixedWidth:310];
    [self.view addSubview:mylabel];
    [mylabel release];
    
}

- (void)backAction
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
