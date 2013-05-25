//
//  ManualViewController.m
//  Instanote
//
//  Created by Man Tung on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ManualViewController.h"
#import "UILabel+Extensions.h"

@interface ManualViewController ()

@end

@implementation ManualViewController

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
    UILabel * mylabel = [[UILabel alloc] init];
    [mylabel setBackgroundColor:[UIColor clearColor]];
    [mylabel setText:@"Are you kidding me?Do not ask me how to use Instanote.'Cause everything so SIMPLE & INSTANT.enjoy youself!"];
    [mylabel setFont:[UIFont systemFontOfSize:30]];
    [mylabel setFrame:CGRectMake(5, 5, 310, 440)];
    [mylabel sizeToFitFixedWidth:310];
    [self.view addSubview:mylabel];
    [mylabel release];
    
    
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
