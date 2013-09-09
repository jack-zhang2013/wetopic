//
//  CircleDescriptionViewController.m
//  Instanote
//
//  Created by CMD on 8/20/13.
//
//

#import "CircleDescriptionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UILabel+Extensions.h"

@interface CircleDescriptionViewController ()

@end

@implementation CircleDescriptionViewController
@synthesize circleentity;

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
    self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];
    self.title = circleentity.circlename;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat userCountViewSize = 74;
    CGFloat userCountViewradius = userCountViewSize / 2;
    
    UIView * circleImageBg = [[UIView alloc] initWithFrame:CGRectMake(123, 28, userCountViewSize, userCountViewSize)];
    circleImageBg.backgroundColor = [UIColor colorWithRed:219/255.f green:108/255.f blue:86/255.f alpha:1];
    [circleImageBg.layer setMasksToBounds:YES];
    [circleImageBg.layer setCornerRadius:userCountViewradius];
    [circleImageBg.layer setBorderWidth:3];
    UIColor *pinkorangee = [UIColor colorWithRed:219/255.f green:93/255.f blue:73/255.f alpha:1];
    [circleImageBg.layer setBorderColor:[pinkorangee CGColor]];
    [self.view addSubview:circleImageBg];
    [circleImageBg release];
    
    CGFloat circleImageviewSize = 55;
    UIImageView *circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(132.5, 37, circleImageviewSize, circleImageviewSize)];
    circleImageView.backgroundColor = [UIColor whiteColor];
    [circleImageView.layer setMasksToBounds:YES];
    CGFloat radius = circleImageviewSize / 2;
    [circleImageView.layer setCornerRadius:radius];
    [circleImageView.layer setBorderWidth:2];
    [circleImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    NSString *imageurl = [NSString stringWithFormat:@"http://%@/%@", API_DOMAIN, circleentity.circlebigimg];
    [circleImageView setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"circle_placeholder.png"]];
    [self.view addSubview:circleImageView];
    
    [circleImageView release];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    CGFloat contentHeight = frame.size.height - 120;
    UIScrollView * contentview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, 320, contentHeight)];
    contentview.backgroundColor = [UIColor colorWithRed:241/255.f green:241/255.f blue:241/255.f alpha:1];
    
    UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont fontWithName:FONT_NAME size:16];
    contentLabel.text = circleentity.summary;
    [contentLabel sizeToFitFixedWidth:300];
    
    [contentview addSubview:contentLabel];
    
    [self.view addSubview:contentview];
    
    [contentLabel release];
    [contentview release];
}


- (UIBarButtonItem *)leftButtonForCenterPanel {
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake(0, 0, 50, 44);
    [face setImage:[UIImage imageNamed:@"circle_back_normal.png"] forState:UIControlStateNormal];
    //    [face setImage:[UIImage imageNamed:@"circle_back_highlight.png"] forState:UIControlStateHighlighted];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
