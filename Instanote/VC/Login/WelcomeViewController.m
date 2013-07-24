//
//  WelcomeViewController.m
//  Instanote
//
//  Created by CMD on 7/19/13.
//
//

#import "WelcomeViewController.h"
#import "CycleScrollView.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    
    
    [picArray addObject:[UIImage imageNamed:@"welcome_0.png"]];
    [picArray addObject:[UIImage imageNamed:@"welcome_1.png"]];
    [picArray addObject:[UIImage imageNamed:@"welcome_2.png"]];
    [picArray addObject:[UIImage imageNamed:@"welcome_3.png"]];
    
    
    
    CGRect bound = [[UIScreen mainScreen] bounds];
    CycleScrollView *cycle = [[CycleScrollView alloc] initWithFrame:bound
                                                     cycleDirection:CycleDirectionLandscape
                                                           pictures:picArray];
    cycle.delegate = self;
    [self.view addSubview:cycle];
    [cycle release];
    [picArray release];
    
}

- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didSelectImageView:(int)index {
    if (index == 4) {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didScrollImageView:(int)index {
//    self.title = [NSString stringWithFormat:@"第%d张", index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
