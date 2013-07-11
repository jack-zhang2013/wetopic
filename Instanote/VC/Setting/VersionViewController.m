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
    
//    UIButton *btn_back = [[UIButton alloc] initWithFrame:CGRectMake(5, 11, 50, 22)];
//    [btn_back setTitle:@"完成" forState:UIControlStateNormal];
//    [btn_back setBackgroundColor:[UIColor grayColor]];
//    [btn_back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.navigationController.navigationBar addSubview:btn_back];
//    [btn_back release];
    
    self.navigationItem.leftBarButtonItem = [self leftButtonForCenterPanel];//[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIImageView * imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aboutyizu.png"]];
    imageview.frame = CGRectMake(0, 0, 320, 500);
    
    [scrollview addSubview:imageview];
    scrollview.contentSize = CGSizeMake(320, 500 + 70);
    [self.view addSubview:scrollview];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [imageview release];
    [scrollview release];
    
	// Do any additional setup after loading the view.
}

- (UIBarButtonItem *)leftButtonForCenterPanel {
    UIImage *faceImage = [UIImage imageNamed:@"arrow.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 12, 12, 24, 16 );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:face];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
