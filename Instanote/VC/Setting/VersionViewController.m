//
//  VersionViewController.m
//  Instanote
//
//  Created by Man Tung on 12/26/12.
//
//

#import "VersionViewController.h"
#import "UILabel+Extensions.h"

@interface VersionViewController ()

@end

@implementation VersionViewController

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
    
//    UIButton *btn_back = [[UIButton alloc] initWithFrame:CGRectMake(10, 11, 33, 22)];
//    [btn_back setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
//    [btn_back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:btn_back];
//    [btn_back release];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * version = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 310, 400)];
    version.text = @"我们是精神富足，乐享生活的一族。在喧嚣都市中，我们想往涓涓清流。\n\n不管我们身处这个城市的哪一个角落，总有与我们爱好相通，志趣相投的人。\n\n来吧，从此刻开始，开辟或加入专属自己的逸族圈子吧。哪怕你的爱好再小众，在这里也可以找到你的知己。让我们的身边簇拥着知己，一起分享，一起品位生活的点点滴滴。让我们与漂泊无所，孤独无依感，挥手作别，从这里开启你的第二人生。\n\n\n逸族网CEO\n李勇";
    version.font = [UIFont fontWithName:FONT_NAME size:15];
    version.backgroundColor = [UIColor clearColor];
    [version sizeToFitFixedWidth:315];
    [self.view addSubview:version];
    [version release];
    
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
//    [btn_back setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
//    [btn_back setHidden:YES];
}

- (void)backAction
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
//    [btn_back release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
//    btn_back = nil;
}

@end
