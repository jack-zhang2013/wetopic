//
//  CoverViewController.m
//  Instanote
//
//  Created by CMD on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoverViewController.h"

@interface CoverViewController ()

@end

@implementation CoverViewController

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
	// Do any additional setup after loading the view.
    
    UIButton * login_Btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [login_Btn setTitle:@"Login In" forState:UIControlStateNormal];
    [login_Btn setFrame:CGRectMake(30, 400, 120, 30)];
    
    
    UIButton * signup_Btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [signup_Btn setTitle:@"Sign Up" forState:UIControlStateNormal];
    [login_Btn setFrame:CGRectMake(170, 400, 120, 30)];
    
    
    
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
